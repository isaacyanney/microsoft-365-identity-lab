# Microsoft 365 Identity & Endpoint Administration Lab

[![PowerShell validation and Pester tests](https://github.com/isaacyanney/microsoft-365-identity-lab/actions/workflows/powershell-syntax.yml/badge.svg)](https://github.com/isaacyanney/microsoft-365-identity-lab/actions/workflows/powershell-syntax.yml)

A portfolio lab for the operational design behind Microsoft 365, Entra ID and Intune administration. It demonstrates identity lifecycle planning, least-privilege access, Conditional Access troubleshooting, endpoint compliance and reviewable PowerShell automation.

## Scope and evidence boundary

This repository is a reproducible design and automation lab. It does not claim deployment to a live Microsoft tenant. The sample domain, users and identities are synthetic. Genuine screenshots and exports remain pending until produced in an authorised tenant.

## What the project demonstrates

- Joiner–Mover–Leaver identity controls
- Role-, group- and licence-based access planning
- MFA and Conditional Access interpretation
- Intune enrolment and compliance troubleshooting
- Safe pilot, exception and rollback procedures
- Behaviour-tested PowerShell change planning
- Security-conscious ticket and administrative documentation

## Recruiter review path

1. Read the [replacement-device sign-in case study](docs/case-study-device-compliance-signin.md).
2. Review the [Joiner–Mover–Leaver controls](docs/joiner-mover-leaver.md).
3. Inspect the [Conditional Access baseline](policies/conditional-access-baseline.md) and [Intune baseline](docs/intune-baseline.md).
4. Review the [change-plan script](scripts/New-IdentityChangePlan.ps1) and [Pester tests](tests/New-IdentityChangePlan.Tests.ps1).
5. See the [synthetic example output](sample-output/identity-plan.example.json) and [authorised evidence guide](docs/evidence-capture.md).

## Repository structure

```text
├── data/lab-users.csv
├── scripts/New-IdentityChangePlan.ps1
├── tests/New-IdentityChangePlan.Tests.ps1
├── sample-output/identity-plan.example.json
├── docs/joiner-mover-leaver.md
├── docs/intune-baseline.md
├── docs/case-study-device-compliance-signin.md
├── docs/evidence-capture.md
├── policies/conditional-access-baseline.md
└── .github/workflows/powershell-syntax.yml
```

## Generate a change plan

```powershell
.\scripts\New-IdentityChangePlan.ps1 `
  -InputPath .\data\lab-users.csv `
  -OutputPath .\output\identity-plan.json
```

The script validates each record and produces reviewable joiner, mover, leaver or access-review actions. It intentionally makes no Microsoft Graph calls and performs no tenant changes.

## Automated validation

GitHub Actions parses every PowerShell file and runs Pester tests that verify:

- valid joiners produce reviewable plans with MFA registration;
- invalid status, UPN and manager data are rejected;
- leaver actions preserve approval and retention controls;
- missing input columns fail safely;
- generated reports explicitly state that no tenant changes occurred.

## Administrative workflow

1. Receive an approved request.
2. Validate the identity record.
3. Generate and review the change plan.
4. Confirm least privilege and approval ownership.
5. Pilot in an authorised tenant.
6. Validate the sign-in, access and device outcome.
7. Record evidence and rollback results.

## Authorised-tenant completion checklist

- Connect a dedicated test tenant
- Replace the example domain with the verified tenant domain
- Implement Microsoft Graph authentication using least-privilege permissions
- Run Conditional Access policies in report-only mode
- Test with dedicated pilot identities and emergency-access controls
- Export sanitised policy, sign-in and compliance evidence
- Document rollback tests and results

## Security principles

No passwords, tokens, MFA codes or private tenant data are stored here. Destructive account and device actions require explicit approval, ownership verification and an organisation-specific retention process.

## Author

**Isaac Lovelace Yanney** — IT Support & Technical Operations  
[GitHub](https://github.com/isaacyanney) · [LinkedIn](https://www.linkedin.com/in/isaac-lovelace-yanney/) · [Portfolio](https://isaacyanney.github.io)
