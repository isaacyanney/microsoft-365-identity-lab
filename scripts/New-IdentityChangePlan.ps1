<#
.SYNOPSIS
Builds a reviewable joiner, mover and leaver change plan from CSV input.

.DESCRIPTION
This lab script does not connect to Microsoft Graph or change a tenant. It
validates synthetic identity records and produces a structured plan that an
administrator can review before implementing approved changes.

.EXAMPLE
.\scripts\New-IdentityChangePlan.ps1 -InputPath .\data\lab-users.csv -OutputPath .\output\identity-plan.json
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$InputPath,
    [Parameter()][string]$OutputPath = ".\output\identity-plan.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$requiredColumns = @("EmployeeId","DisplayName","UserPrincipalName","Department","Role","Manager","LicenseProfile","AccessProfile","Status")
$records = @(Import-Csv -Path $InputPath)
if ($records.Count -eq 0) { throw "Input file contains no identity records." }

$missingColumns = @($requiredColumns | Where-Object { $_ -notin $records[0].PSObject.Properties.Name })
if ($missingColumns.Count -gt 0) { throw "Missing columns: $($missingColumns -join ', ')" }

$allowedStates = @("Joiner","Mover","Leaver","Active")
$plans = foreach ($record in $records) {
    $validation = [System.Collections.Generic.List[string]]::new()
    if ($record.Status -notin $allowedStates) { $validation.Add("Unsupported status") }
    if ($record.UserPrincipalName -notmatch "^[^@]+@[^@]+\.[^@]+$") { $validation.Add("Invalid UPN") }
    if ([string]::IsNullOrWhiteSpace($record.Manager)) { $validation.Add("Manager approval reference required") }

    $actions = switch ($record.Status) {
        "Joiner" {
            @("Create cloud identity","Assign license profile: $($record.LicenseProfile)","Assign access profile: $($record.AccessProfile)","Require MFA registration","Record manager approval")
        }
        "Mover" {
            @("Review existing group memberships","Apply department: $($record.Department)","Apply access profile: $($record.AccessProfile)","Remove access no longer justified","Record manager approval")
        }
        "Leaver" {
            @("Block interactive sign-in","Revoke active sessions","Remove group and application access","Preserve business data per policy","Recover licenses after retention review")
        }
        default { @("No lifecycle change requested","Include in periodic access review") }
    }

    [pscustomobject]@{
        EmployeeId = $record.EmployeeId
        UserPrincipalName = $record.UserPrincipalName
        ChangeType = $record.Status
        ApprovalState = "Pending"
        ValidationPassed = $validation.Count -eq 0
        ValidationMessages = @($validation)
        PlannedActions = @($actions)
    }
}

$report = [pscustomobject]@{
    SchemaVersion = "1.0"
    GeneratedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
    Environment = "Synthetic lab"
    ContainsTenantChanges = $false
    RecordCount = $plans.Count
    ReadyForReview = @($plans | Where-Object ValidationPassed).Count
    Plans = @($plans)
}

$directory = Split-Path -Parent $OutputPath
if ($directory -and -not (Test-Path $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
$report | ConvertTo-Json -Depth 7 | Set-Content -Path $OutputPath -Encoding UTF8
Write-Output $report
