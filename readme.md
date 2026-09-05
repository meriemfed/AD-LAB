# Enterprise Active Directory & Group Policy Security Lab

## 📌 Project Overview
This project demonstrates the design, deployment, and security hardening of an enterprise Windows Active Directory environment. It involves configuring a Windows Server 2019 Domain Controller, establishing a departmental Organizational Unit (OU) structure, automating user provisioning with PowerShell, and enforcing strict security baselines using Group Policy Objects (GPOs).

## 🎯 Objectives
* Deploy and configure a Windows Server 2019 Domain Controller (`corp.local`).
* Establish a segmented corporate network using VMware NAT routing.
* Automate the creation of users and security groups across multiple departments (IT, HR, Accounting, Finance).
* Enforce domain-wide security baselines (Password Complexity, Legal Logon Banners).
* Apply department-specific hardware and UI restrictions using GPOs (USB Write Denial, Control Panel/Task Manager blocks).

## 🏗️ Architecture & Network Topology
* **Hypervisor:** VMware Workstation Pro
* **Network:** `VMnet8` (NAT) | Subnet: `192.168.112.0/24`
* **Domain Controller (DC01):** Windows Server 2019 | `192.168.112.10`
* **Client Machine (Accounting):** Windows 10 Enterprise | `192.168.112.20`

## 🛠️ Technologies & Tools Used
* Windows Server 2019 / Windows 10
* Active Directory Domain Services (AD DS) & DNS
* Group Policy Management (GPMC)
* PowerShell (Automation & Scripting)
* VMware Virtual Networking

## 📁 Repository Structure
Navigate through the documentation below to see the exact configurations, scripts, and testing evidence for this environment:

| Directory/File | Description |
| :--- | :--- |
| 📄 [report/env-setup.md](report/env-setup.md) | Detailed breakdown of VM specifications, IP configurations, and Active Directory promotion. |
| 📄 [report/gpo-config.md](report/gpo-config.md) | Comprehensive documentation of the GPO paths, security settings, and successful application outcomes. |
| 📂 `configs/` | Contains the `user-generation.ps1` PowerShell script used to automate AD object creation. |
| 📂 `images/` | Contains visual evidence of network configs, GPO restrictions and AD structures. |

## 🚀 Key Highlights & Testing
To validate the security posture, the `SEC-Accounting-Lockdown` GPO was tested against a standard user account (`smiller`). 

* **Hardware Security:** Successfully blocked unauthorized data exfiltration by enforcing a USB "Deny Write" policy at the machine level.
* **System Integrity:** Prevented standard users from modifying system configurations by restricting access to `control.exe` and `taskmgr.exe`.

