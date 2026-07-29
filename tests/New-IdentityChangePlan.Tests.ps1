BeforeAll {
    $scriptPath = Join-Path $PSScriptRoot '..\scripts\New-IdentityChangePlan.ps1'
}

Describe 'New-IdentityChangePlan' {
    It 'has valid PowerShell syntax' {
        $tokens = $null
        $errors = $null
        [System.Management.Automation.Language.Parser]::ParseFile($scriptPath,[ref]$tokens,[ref]$errors) | Out-Null
        $errors.Count | Should -Be 0
    }

    It 'creates a reviewable joiner plan without tenant changes' {
        $inputPath = Join-Path $TestDrive 'joiner.csv'
        $outputPath = Join-Path $TestDrive 'joiner-plan.json'
        @'
EmployeeId,DisplayName,UserPrincipalName,Department,Role,Manager,LicenseProfile,AccessProfile,Status
LAB-101,Amina Boateng,amina.boateng@contoso.example,Finance,Analyst,manager@contoso.example,M365-Business-Premium,Finance-Standard,Joiner
'@ | Set-Content -Path $inputPath -Encoding UTF8
        & $scriptPath -InputPath $inputPath -OutputPath $outputPath | Out-Null
        $result = Get-Content -Path $outputPath -Raw | ConvertFrom-Json
        $result.Environment | Should -Be 'Synthetic lab'
        $result.ContainsTenantChanges | Should -BeFalse
        $result.RecordCount | Should -Be 1
        $result.ReadyForReview | Should -Be 1
        $result.Plans[0].ApprovalState | Should -Be 'Pending'
        $result.Plans[0].PlannedActions | Should -Contain 'Require MFA registration'
    }

    It 'rejects unsupported status, invalid UPN and missing manager approval' {
        $inputPath = Join-Path $TestDrive 'invalid.csv'
        $outputPath = Join-Path $TestDrive 'invalid-plan.json'
        @'
EmployeeId,DisplayName,UserPrincipalName,Department,Role,Manager,LicenseProfile,AccessProfile,Status
LAB-102,Invalid User,invalid-upn,Finance,Analyst,,M365-Business-Premium,Finance-Standard,Unknown
'@ | Set-Content -Path $inputPath -Encoding UTF8
        & $scriptPath -InputPath $inputPath -OutputPath $outputPath | Out-Null
        $result = Get-Content -Path $outputPath -Raw | ConvertFrom-Json
        $result.ReadyForReview | Should -Be 0
        $result.Plans[0].ValidationPassed | Should -BeFalse
        $result.Plans[0].ValidationMessages | Should -Contain 'Unsupported status'
        $result.Plans[0].ValidationMessages | Should -Contain 'Invalid UPN'
        $result.Plans[0].ValidationMessages | Should -Contain 'Manager approval reference required'
    }

    It 'keeps controlled leaver actions pending approval' {
        $inputPath = Join-Path $TestDrive 'leaver.csv'
        $outputPath = Join-Path $TestDrive 'leaver-plan.json'
        @'
EmployeeId,DisplayName,UserPrincipalName,Department,Role,Manager,LicenseProfile,AccessProfile,Status
LAB-103,Maya Owusu,maya.owusu@contoso.example,People,Coordinator,manager@contoso.example,M365-Business-Premium,People-Standard,Leaver
'@ | Set-Content -Path $inputPath -Encoding UTF8
        & $scriptPath -InputPath $inputPath -OutputPath $outputPath | Out-Null
        $result = Get-Content -Path $outputPath -Raw | ConvertFrom-Json
        $result.Plans[0].ApprovalState | Should -Be 'Pending'
        $result.Plans[0].PlannedActions | Should -Contain 'Block interactive sign-in'
        $result.Plans[0].PlannedActions | Should -Contain 'Preserve business data per policy'
        $result.Plans[0].PlannedActions | Should -Contain 'Recover licenses after retention review'
    }

    It 'fails when required CSV columns are missing' {
        $inputPath = Join-Path $TestDrive 'missing-columns.csv'
        @'
EmployeeId,DisplayName
LAB-104,Incomplete User
'@ | Set-Content -Path $inputPath -Encoding UTF8
        { & $scriptPath -InputPath $inputPath -OutputPath (Join-Path $TestDrive 'unused.json') } | Should -Throw '*Missing columns*'
    }
}
