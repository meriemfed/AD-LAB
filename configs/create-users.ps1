# create-global-users.ps1
$departments = @("IT", "ACCOUNTING", "HR", "FINANCE")
$namesByDept = @{
    "IT"         = @("Marcus Johnson", "Chloe Bennett", "David Kim", "Elena Rodriguez", "Alexander Wright")
    "ACCOUNTING" = @("Stacy Miller", "Liam Carter", "Sophia Weber", "James Taylor", "Aisha Patel")
    "HR"         = @("Emma Thompson", "Noah Williams", "Olivia Martinez", "William Davies", "Isabella Ricci")
    "FINANCE" = @("Lucas Brown", "Mia Silva", "Benjamin Clark", "Charlotte Jones", "Ethan White")
}

foreach ($dept in $departments) {
    # 1. Create the Organizational Unit (OU) if it doesn't exist
    $ouPath = "OU=$dept,DC=corp,DC=local"
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$dept'")) {
        New-ADOrganizationalUnit -Name $dept -Path "DC=corp,DC=local"
    }

    # 2. Create the users inside the OU
    $names = $namesByDept[$dept]
    foreach ($fullName in $names) {
        $first, $last = $fullName -split " ", 2
        # Creates a login format like "smiller" (First initial + Last name)
        $sam = ($first.Substring(0, 1) + $last).ToLower() -replace '\s', ''
        
        New-ADUser -Name $fullName -GivenName $first -Surname $last `
            -SamAccountName $sam -UserPrincipalName "$sam@corp.local" `
            -Path $ouPath `
            -AccountPassword (ConvertTo-SecureString "Changeme2026!" -AsPlainText -Force) `
            -Enabled $true -ChangePasswordAtLogon $true
    }
}