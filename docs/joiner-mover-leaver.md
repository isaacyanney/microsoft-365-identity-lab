# Joiner–Mover–Leaver Control Runbook

## Joiner

1. Confirm an approved request, start date, manager and department.
2. Select the least-privilege role and licence profile.
3. Create the identity using the approved naming standard.
4. Assign groups through role-based access, not individual exceptions.
5. Require MFA registration and approved recovery methods.
6. Enrol the device and verify compliance before granting sensitive access.
7. Test the user's required services and record completion evidence.

## Mover

1. Confirm the effective date and approvals from both relevant managers.
2. Compare current access with the new role profile.
3. Add new access only after approval.
4. Remove access that is no longer justified.
5. Review privileged roles, shared mailboxes and application assignments.
6. Record the change, validation and any time-limited exception.

## Leaver

1. Confirm the authorised access-cutoff time.
2. Block sign-in and revoke active sessions.
3. Remove privileged and application access.
4. Preserve mailbox and file ownership according to policy.
5. Recover licences only after retention requirements are checked.
6. Retire or preserve the identity according to the retention standard.
7. Record asset recovery and closure evidence.

## Separation of duties

The requester, approver and executor should be distinguishable in the ticket. Emergency changes require retrospective review. Passwords, MFA codes and recovery secrets do not belong in tickets or scripts.
