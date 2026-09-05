## Lab Environment Setup

### 1. Virtual Machine Specifications
*   **Hypervisor:** VMware Workstation Pro
*   **Domain Controller (DC01):** Windows Server 2019 Standard (Desktop Experience) | 4GB RAM | 30GB Storage
*   **Client Machine:** Windows 10 Enterprise | 4GB RAM | 30GB Storage

### 2. Network Configuration
*   **Network Type:** VMware VMnet8 (NAT - routing over host wireless adapter)
*   **Subnet:** `192.168.112.0/24`
*   **Gateway:** `192.168.112.2`

### 3. Domain Controller Initial Setup (DC01)
*   Attached VM to `VMnet8`.
*   Created a baseline VMware snapshot (`00-clean-install`).
*   **Local Administrator Password:** `Asus2008`
*   Set a static IP inside the guest OS:
    *   **IP Address:** `192.168.112.10`
    *   **Subnet Mask:** `255.255.255.0`
    *   **Default Gateway:** `192.168.112.2`
    *   **DNS Server:** `127.0.0.1` (Self-hosted DNS)
*   Renamed the hostname to `DC01` and rebooted.

### 4. Active Directory Promotion
*   Installed **Active Directory Domain Services (AD DS)** and **DNS Server** roles via Server Manager.
*   Promoted the server to a Domain Controller:
    *   **Deployment Type:** Add a new forest
    *   **Root Domain Name:** `corp.local`
    *   **DSRM Password:** `Corp2026!`

### 5. Organizational Structure & Users
Created the directory structure manually via Active Directory Users and Computers (`dsa.msc`):
*   `OU=IT`
*   `OU=ACCOUNTING`
*   `OU=HR`
*   `OU=FINANCE`

**Automation & Permissions:**
*   Created corresponding security groups for each department (e.g., `GRP-IT`, `GRP-ACCOUNTING`).
*   Used a custom PowerShell script to automatically generate 20 fictional users and assign them to their respective OUs and security groups. *(Note: Script is available in the `/configs` directory).*
*   **Standard Domain User Password:** `Corplocal2026!`

### 6. Client Machine Setup (Windows 10)
*   **Local Administrator Credentials:** `windows10` / `windows10`
*   Attached VM to `VMnet8`.
*   Set a static IP to ensure resolution with the Domain Controller:
    *   **IP Address:** `192.168.112.20`
    *   **Subnet Mask:** `255.255.255.0`
    *   **Default Gateway:** `192.168.112.2`
    *   **DNS Server:** `192.168.112.10` (Points to DC01)
*   Joined the machine to the `corp.local` domain.