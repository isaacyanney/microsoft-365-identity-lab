# Troubleshooting Case Study: Microsoft 365 Sign-In Blocked After Device Replacement

## Scenario

A synthetic Finance user receives a replacement Windows laptop and cannot access Microsoft 365. Authentication and MFA complete, but access is blocked because the device does not meet the organisation’s security requirements.

This case study models an authorised support investigation. It does not claim access to a production tenant.

## Initial ticket

| Field | Value |
|---|---|
| User | Amina Boateng |
| Device | FIN-LT-014 |
| Impact | Microsoft 365 applications unavailable |
| Recent change | Replacement laptop issued |
| Authentication | Password and MFA successful |
| Priority | P3 in this fictional scenario |

## Investigation

1. Record the exact message and timestamp without collecting passwords, MFA codes or tokens.
2. Confirm whether browser and desktop applications are both affected.
3. In an authorised tenant, locate the Entra ID sign-in event using the user, application and timestamp.
4. Review authentication result, Conditional Access status, device state, client application and correlation identifiers.
5. Compare the device identity with the authorised Intune record and assigned compliance policy.

## Evidence interpretation

- Primary authentication: successful
- MFA requirement: satisfied
- Conditional Access policy: CA-Require-Compliant-Device
- Grant result: blocked
- Device state: registered but not compliant
- Intune state: enrolment incomplete

The evidence separates an identity failure from an endpoint-compliance failure.

## Root cause

The replacement laptop was registered but had not completed Intune enrolment and compliance evaluation. Conditional Access correctly blocked access because the required device state was missing.

## Resolution

1. Confirmed that the device was authorised and assigned to the user.
2. Completed the approved Intune enrolment workflow.
3. Triggered a device sync and reviewed the compliance policy.
4. Corrected the missing BitLocker recovery-key escrow requirement in this lab scenario.
5. Confirmed that the device reported compliant.
6. Repeated the sign-in and verified that the same policy granted access.
7. Recorded the before/after event identifiers and outcome.

No user exclusion or broad policy bypass was used.

## Ticket closure note

> Authentication and MFA succeeded, but Conditional Access blocked FIN-LT-014 because enrolment and compliance evaluation were incomplete. Device ownership was verified, approved enrolment was completed and the missing BitLocker escrow requirement was remediated. The device reported compliant and access was restored. No credentials or MFA codes were collected.

## Escalation boundary

Escalate when sign-in evidence is unavailable to the support role, a policy affects multiple users unexpectedly, the device remains non-compliant, or a policy change, exclusion or emergency-access procedure is proposed.

## Skills demonstrated

Entra ID sign-in analysis, Conditional Access interpretation, Intune compliance troubleshooting, secure user communication, least-privilege escalation and evidence-based closure.
