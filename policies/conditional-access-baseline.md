# Conditional Access Baseline — Design Only

This document describes a lab policy set. It is not evidence of deployment to a live tenant.

| Policy | Users | Cloud apps | Condition | Grant control | Deployment |
|---|---|---|---|---|---|
| Require MFA | All users | All apps | Any location | Require MFA | Report-only first |
| Block legacy authentication | All users | All apps | Legacy clients | Block | Report-only first |
| Require compliant device | Finance and IT | Selected apps | Windows/macOS | Compliant device | Pilot group |
| Protect admin roles | Admin roles | Admin portals | Any location | Phishing-resistant MFA | Emergency accounts excluded |
| Session control | External users | SharePoint/Teams | Unmanaged device | Limited web access | Pilot group |

## Safe rollout

1. Create two monitored emergency-access accounts.
2. Exclude them only where the control design requires it.
3. Start in report-only mode.
4. Review sign-in impact for at least one normal business cycle.
5. Pilot with IT users.
6. Record exceptions with owner and expiry.
7. Enable gradually and monitor sign-in failures.
8. Maintain a tested rollback procedure.

## Evidence to capture in a real lab

- policy export
- pilot membership
- report-only results
- approved exceptions
- test cases and expected outcomes
- rollback owner and validation
