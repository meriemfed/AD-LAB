# Joiner / Mover / Leaver Process — Active Directory Lab

**Status note:** The Joiner process below was implemented and verified in the lab
(see `create-users.ps1` and `create-groups.ps1` ). Mover and Leaver
are documented as designed processes for this environment but have not yet been
scripted or tested in the lab.

## Joiner

**Trigger:** HR sends a new-hire file to IT.

**Who acts:** IT employee performs the account creation; approved by the IT Head
before execution.

**Steps:**
1. IT Head reviews and approves the new-hire request from HR
2. IT employee creates the department OU if it doesn't already exist
3. AD user account is created inside the correct department OU
4. Temporary password is set, with forced change at first logon
5. User is added to the department security group (`GRP-<department>`)
6. Domain password policy applies automatically via GPO inheritance
7. IT logs the action: date, new hire's name, OU/group assigned, performed by, approved by

**Verification:** Confirm the account appears in the correct OU and group, and
that the user can log in and is prompted to change their password.

**Known gap:** Accounts are created active immediately; there is no
disable-until-start-date step yet. Noted as a future improvement.

---

## Mover

**Trigger:** Employee submits a transfer request to HR.

**Who acts:** HR verifies the request is legitimate and forwards it to IT.
IT Head approves the final change.

**Steps:**
1. Employee submits transfer request to HR
2. HR verifies the request and requests IT to act
3. IT removes the employee's old group membership immediately
4. Employee is notified their access is changing and to avoid using the
   account until the change is complete, to prevent working with stale
   permissions mid-transfer
5. IT Head approves the OU change and new group assignment
6. IT moves the AD object to the new department OU and adds the employee
   to the new department's security group
7. IT logs the action: date, employee name, old OU/group → new OU/group, performed by, approved by

**Rationale:** Old access is removed before new access is granted (rather
than granting new access first) to avoid a window where the employee holds
both old and new permissions at once.

---

## Leaver

**Trigger:** Employee submits termination to HR (or manager reports it to HR).

**Who acts:** HR sends the termination request to IT, who executes the
same day.

**Steps:**
1. Employee/manager submits termination to HR
2. HR sends termination request to IT
3. IT disables the account immediately, same day
4. Account is removed from all security groups, not just sensitive ones,
   so no access remains
5. Password is reset/rotated even though the account is disabled, so a
   future re-enable can't hand back working credentials
6. Any active sessions are logged off
7. Account is moved to a "Disabled Users" / "Leavers" OU and retained
   there for a defined period (e.g. 90 days) for audit and compliance
   purposes, rather than deleted immediately
8. After the retention period, the account is deleted
9. IT logs the action: date, employee name, reason (termination), performed by, approved by

