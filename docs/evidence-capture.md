# Authorised Microsoft 365 Lab Evidence Guide

Use this guide only with a personally owned or explicitly authorised Microsoft 365 test tenant. Do not capture employer tenant data, real users, passwords, MFA codes, tokens, recovery keys or private device identifiers.

## Evidence checklist

| Evidence | What it demonstrates | Safety requirement |
|---|---|---|
| Synthetic user inventory | Controlled lab identities | Use fictional users and domain |
| Generated change plan | Review before tenant action | Keep ContainsTenantChanges false |
| Entra user and group view | Implemented identity structure | Show lab objects only |
| Conditional Access report-only result | Policy decision before enforcement | Preserve emergency-access controls |
| Sign-in event | Authentication and policy interpretation | Redact unnecessary identifiers |
| Intune enrolment state | Managed-device registration | Use a dedicated lab device |
| Compliance result | Requirement and remediation evidence | Never expose recovery keys |
| Before/after access result | Controlled troubleshooting outcome | Record time and test identity |
| Rollback record | Policy can be safely reversed | Include owner and approval |

## Suggested evidence structure

- evidence/01-lab-inventory.md
- evidence/02-change-plan.json
- evidence/03-identity-and-groups.png
- evidence/04-ca-report-only-result.png
- evidence/05-sign-in-blocked.md
- evidence/06-device-compliance.png
- evidence/07-sign-in-restored.md
- evidence/08-rollback-test.md

Add the evidence folder only when its contents are genuine and reviewed.

## Capture standard

- Use dedicated synthetic identities.
- Crop screenshots to the relevant portal panel.
- Include policy state, test time and expected result in the caption.
- Redact tenant IDs, device IDs, IP addresses and correlation IDs when publication adds no value.
- Never alter or manufacture portal results.
- Preserve failed tests and explain the remediation.
- Run Conditional Access changes in report-only mode before enforcement.

## Evidence record template

- Date:
- Tenant owner:
- Synthetic identity:
- Change or test:
- Expected result:
- Observed result:
- Pass/fail:
- Rollback performed:
- Sanitisation performed:

## Completion rule

Evidence is complete only after the corresponding action has been performed in an authorised tenant and reviewed for sensitive information.
