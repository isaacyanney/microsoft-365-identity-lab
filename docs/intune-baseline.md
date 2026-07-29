# Intune Endpoint Baseline — Lab Design

## Enrollment

- Company-owned Windows devices use Autopilot where available.
- Personally owned Windows enrolment is blocked unless policy explicitly permits it.
- Device naming, ownership and primary-user data follow a documented standard.
- Enrollment Status Page blocks use until required security controls are applied.

## Compliance signals

- supported operating-system version
- BitLocker enabled
- Secure Boot enabled
- active antimalware protection
- firewall enabled
- acceptable device threat level
- no simple passwords
- grace period defined for recoverable failures

## Configuration profiles

- Defender and firewall baseline
- BitLocker with approved recovery-key escrow
- Windows Update rings
- OneDrive Known Folder Move
- browser security configuration
- local administrator control
- device restrictions appropriate to role

## Support workflow

1. Confirm ownership, last check-in and compliance reason.
2. Compare assigned policy with the intended group.
3. Review per-setting status and recent changes.
4. Trigger a sync only when appropriate.
5. Avoid destructive retire/wipe actions until ownership and approval are verified.
6. Record the result and next evaluation time.
