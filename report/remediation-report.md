# Remediation Report

This report covers the fixes applied to the three findings from the
attack path analysis, and the re-verification steps used to confirm each
fix worked.

## What was fixed

| Finding | Before | Fix applied |
|---|---|---|
| User with Domain Admin rights | Direct member of Domain Admins | Removed from Domain Admins group |
| Group with local admin on the DC | GRP-HelpDesk nested inside Administrators (Builtin) | Removed GRP-HelpDesk from Administrators |
| Service account with excess rights | Member of Server Operators, password never expires | Removed from Server Operators, unchecked "password never expires," password reset |

## How each fix was verified

Re-ran SharpHound on the same workstation used for the original
collection, uploaded the new data into BloodHound , then re-ran the
same three checks used in the attack analysis.

| Finding | Query used | Result after fix |
|---|---|---|
| User with Domain Admin rights | Shortest Paths to Domain Admins | No results — user no longer appears |
| Group with local admin on the DC | AD hygiene, nested groups in Tier Zero / High Value | No results — group no longer nested in Administrators |
| Service account with excess rights | Users with password never expires | Only the built-in Administrator account shows, which is expected. The service account no longer appears. |

## Notes on the fixes

- The user's Domain Admin access was removed entirely rather than
  replaced with a smaller group, since nothing in the lab depends on
  that account having elevated access.
- For the nested-group finding, removing the group from Administrators
  solves the immediate issue. Standing admin access like
 this should be replaced with just-in-time access granted temporarily
  when needed instead of permanent group membership .
- The service account had two separate problems, so both were fixed
  separately: removed from Server Operators , and password setting corrected.
  

