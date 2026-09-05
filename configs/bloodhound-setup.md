# BloodHound CE Setup and Data Collection

## Environment
- BloodHound CE installed via Docker Compose, run on host machine
- SharpHound collector run on CLIENT01 (domain-joined workstation),
  logged in as a standard domain user

## 1. BloodHound CE installation

Installed using the official Docker Compose file:

```bash
curl -L https://ghst.ly/getbhce -o docker-compose.yml
docker compose pull
docker compose up
```



## 2. SharpHound collector setup (on CLIENT01)

Downloaded SharpHound from the official SpecterOps GitHub releases page,
extracted to `C:\Tools\SharpHound\`.

Windows Defender flagged the executable as a hacktool (expected).
Added a local exclusion scoped to this folder only, on this isolated lab
VM only:

```powershell
Add-MpPreference -ExclusionPath "C:\Tools\SharpHound"
```

## 3. Data collection

Ran SharpHound against the domain from CLIENT01:

```powershell
cd C:\Tools\SharpHound
.\SharpHound.exe -c All
```

Output: a timestamped zip file containing JSON data on users, groups,
computers, sessions, and ACLs across the domain.



## 4. Data ingestion

Uploaded the SharpHound output zip into BloodHound CE via the web UI
upload feature. Ingestion completed successfully, confirmed via the
node/edge counts shown in the BloodHound dashboard.

## Note — virtualization conflict encountered

Docker Desktop initially failed with "virtualization support not detected,"
despite Hyper-V being enabled. Root cause: Virtual Machine Platform and
Windows Subsystem for Linux (WSL) were not enabled, likely disabled
previously to avoid a conflict with VMware Workstation. Enabling both
features (Windows Features > Virtual Machine Platform, WSL) resolved the
issue with no negative effect on existing VMware VMs, since modern Windows
virtualization (Hyper-V, WSL2, and VMware) can share the underlying
hypervisor layer rather than requiring exclusive access.