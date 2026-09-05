## Group Policy (GPO) Configuration

To enforce security baselines across the environment, the following Group Policy Objects were created, configured, and linked within the `corp.local` domain.

### 1. Domain-Level Policies (Linked to Root: `corp.local`)
These policies apply globally to all machines and users across the domain.

*   **Modified GPO: `Default Domain Policy`**
    *   **Path:** `Computer Configuration > Policies > Windows Settings > Security Settings > Account Policies > Password Policy`
    *   **Minimum password length:** 12 characters
    *   **Maximum password age:** 90 days
    *   **Password complexity:** Enabled

*   **New GPO: `SEC-Login-Banner`**
    *   **Path:** `Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options`
    *   **Interactive logon (Message title):** `UNAUTHORIZED ACCESS PROHIBITED`
    *   **Interactive logon (Message text):** `This system is for authorized corporate use only.`

### 2. Department-Level Policies (Linked to `OU=ACCOUNTING`)
These policies are targeted specifically at the Accounting department to restrict standard user configuration and secure physical hardware interfaces.

*   **New GPO: `SEC-Accounting-Lockdown`**
    *   **Path (User Settings - UI Restrictions):** `User Configuration > Policies > Administrative Templates > Control Panel`
        *   **Setting applied:** Prohibit access to Control Panel and PC settings -> **Enabled**
    *   **Path (User Settings - System Restrictions):** `User Configuration > Policies > Administrative Templates > System > Ctrl+Alt+Del Options`
        *   **Setting applied:** Remove Task Manager -> **Enabled**
    *   **Path (Computer Settings - Hardware Control):** `Computer Configuration > Policies > Administrative Templates > System > Removable Storage Access`
        *   **Setting applied:** Removable Disks: Deny write access -> **Enabled**

### 3. GPO Application & Asset Placement
To ensure both User and Computer configurations within the `SEC-Accounting-Lockdown` GPO applied correctly, network assets were segmented into the proper Organizational Unit (OU) structure.

*   **Target OU:** `OU=ACCOUNTING,DC=corp,DC=local`
*   **Assets Moved:**
    *   **User Object:** `smiller` (Stacy Miller)
    *   **Computer Object:** Windows 10 Client VM
*   **Justification:** Moving the computer object from the default `CN=Computers` container into the `ACCOUNTING` OU ensures that machine-level hardware restrictions (USB Deny Write) apply alongside the user-level UI restrictions.

### 4. Verification & Testing Outcomes
All policies were verified on the Windows 10 client operating as standard user `smiller`:
*   **Login Banner:** Confirmed pre-authentication warning prompt upon boot.
*   **Password Policy:** Confirmed rejection of passwords failing complexity and length requirements.
*   **UI Lockdown:** Confirmed `Access Denied` / blocked execution when attempting to launch `taskmgr.exe` or `control.exe`.
*   **Hardware Restriction:** Mapped a physical USB drive to the VM; confirmed read visibility but received `Destination Folder Access Denied` when attempting to write new files to the removable disk.