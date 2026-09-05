# Enterprise Active Directory Security Lab — Build, Audit, Remediate

## Overview
This project covers the full lifecycle of securing an enterprise Windows
Active Directory environment: building a domain from scratch, hardening
it with Group Policy, then auditing it for privilege escalation risks
using BloodHound and fixing what was found.

## Key finding
Using BloodHound, this lab identified three separate privilege escalation
paths in the domain — a standard user with direct Domain Admin rights, a
support group with hidden (nested) local admin access on the domain
controller, and a stale service account with a non-expiring password and
excess rights. All three were remediated and verified fixed with a
follow-up BloodHound scan.

## What's in this repo

| File/Folder | Description |
|---|---|
| `report/environment-setup.md` | VM specs, IP configuration, AD promotion |
| `report/gpo-configuration.md` | GPO paths, security settings, testing outcomes |
| `report/jml-process.md` | Joiner/Mover/Leaver process documentation |
| `report/vulnerable-acl.md` | The three privilege misconfigurations, what and where |
| `report/attack-path-analysis.md` | BloodHound findings and how each was discovered |
| `report/remediation-report.md` | Before/after fixes and re-verification |
| `configs/create-users.ps1` | PowerShell script — user and OU provisioning |
| `configs/create-groups.ps1` | PowerShell script — group creation and membership |
| `configs/bloodhound-setup.md` | BloodHound CE + SharpHound install and collection notes |
| `references/sources.md` | Tools and documentation referenced while building the lab |
| `diagrams/ad-lab.drawio.png` | Architecture of the AD lab |
| `screenshots/` | Evidence organized by lab phase (network setup through remediation) |

## Environment
- Hypervisor: VMware Workstation Pro
- Network: VMnet8 (NAT), subnet 192.168.112.0/24
- Domain Controller: Windows Server 2019 , `corp.local`, 192.168.112.10
- Client: Windows 10 Enterprise, 192.168.112.20
- Tools: Active Directory Domain Services, DNS, GPMC, PowerShell, BloodHound CE, SharpHound

## What was built
- Domain with 4 department OUs (IT, HR, Accounting, Finance), 20 users
  provisioned via PowerShell
- Department security groups, bulk-assigned via script
- Domain-wide password policy and legal logon banner
- Department-specific GPOs: USB write denial, Control Panel/Task Manager
  restriction — tested against a standard user account

## What was audited and fixed
Full privilege escalation audit using BloodHound, covering three
different discovery techniques (automated path query, AD hygiene/nested
group check, and account hygiene query) to find risks that a single
method alone would have missed. 