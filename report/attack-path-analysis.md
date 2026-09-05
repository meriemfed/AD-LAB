# Attack Path Analysis

This analysis was conducted using BloodHound CE, fed by a SharpHound
collection run from a standard domain-joined workstation, logged in as an
unprivileged domain user — simulating the perspective of an attacker who
has compromised an ordinary employee account, not an administrator.

## How each one was found

| Finding | How I found it |
|---|---|
| User with Domain Admin rights | Ran BloodHound's "Shortest Paths to Domain Admins" query |
| Group with local admin on the DC | Ran BloodHound's AD hygiene query for nested groups inside Tier Zero / High Value targets |
| Service account with excess rights | Searched for accounts with passwords set to never expire |

I used three different methods because each vulnerability was hidden in
a different way. The first showed up automatically. The second and third
didn't , they needed specific hygiene/property-based queries rather than a simple path
search.


## Finding 1: User with Domain Admin rights

**Found by:** running the Shortest Paths to Domain Admins query.

**What it showed:** the user is a direct member of Domain Admins. One
line connects her account straight to Domain Admins.

**What it means:** if this account is ever hacked or phished, the
attacker instantly controls the entire domain. No extra steps needed.

**Risk:** Critical


## Finding 2: Local admin access on the domain controller, hidden in a group

**Found by:** using BloodHound's AD hygiene query for nested groups
inside Tier Zero / High Value targets. This surfaces groups that are
members of critical/high-value groups, without needing to check each
one by name manually.

**What it showed:** a group was listed as nested inside a Tier Zero
group (Administrators on the domain controller). That nested group
contained two individual user accounts.

**What it means:** two employees have full admin control of the domain
controller, but this isn't visible by just glancing at the direct admin
list — the access is one layer deep, inside a group nested within a
group. Admin access on the domain controller is as dangerous as Domain
Admin, since the DC holds all the domain's account data. This is exactly
the kind of hidden privilege the AD hygiene query is built to catch.

**Risk:** Critical


## Finding 3: Service account with a password that never expires

**Found by:** searching for accounts with "password never expires"
turned on. This account did not show up in the Domain Admins query,
because its risk isn't a group path it's the group it belongs to
(Server Operators) plus bad password settings.

**What it means:** if this account's password ever leaks (in a script,
an old file, anywhere), it stays valid forever, since it's never forced
to change. The account also has rights to log into the domain
controller and back up/restore files, which could be misused. Nobody
watches this account day-to-day, so nothing would catch misuse quickly.

**Risk:** High