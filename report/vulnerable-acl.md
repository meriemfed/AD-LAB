# Vulnerable State — Privilege Misconfiguration Simulation

This document records three access-control misconfigurations deliberately
introduced into the lab domain (`corp.local`).

## 1. Standard user with excess privilege (Domain Admin)

**What:** A standard department user (`smiller`, OU=ACCOUNTING) was added
directly to the **Domain Admins** group.

**Where:** Active Directory Users and Computers → user account →
Member Of tab.

**What the vulnerability is:** A regular employee account holds the
highest level of access in the domain, even though her job doesn't
require it.

**What it does:** If this account is ever compromised — phishing, stolen
password, malware — the attacker instantly has full control over every
computer, user, and system in the domain. No extra hacking needed, just
one login.

---

## 2. Stale, over-privileged service account

**What:** Service account `svc-backup` was created with:
- Password set to **never expire**
- No forced password change at logon
- Membership in **Server Operators**

**Where:** OU=IT → svc-backup → Account tab (password settings) and
Member Of tab (Server Operators).

**What the vulnerability is:** An account nobody actively watches has a
powerful group membership and a password that will never be forced to
change.

**What it does:** If the password ever leaks (in an old script, a config
file, a document), it stays valid forever, and the account can be used to
gain elevated access on the domain controller — all while blending into
the background, since nobody is checking on it regularly.

---

## 3. Standing local administrator access on the Domain Controller

**What:** Security group `GRP-HelpDesk` (members: mjohnson, cbennett) was
added to the **Builtin\Administrators** group on the domain controller.

**Where:** Active Directory Users and Computers → Builtin → Administrators
→ Members tab.

**What the vulnerability is:** Two regular support staff accounts have
full admin rights on the domain controller itself, all the time — not
just when they're actually doing support work that needs it.

**What it does:** If either of these two accounts is compromised, the
attacker gets the same level of access as a Domain Admin, since admin
rights on the domain controller is effectively the same thing. That risk
exists 24/7, even during the 99% of the time neither person is doing
anything that requires that access.

---

