# Create the groups
New-ADGroup -Name "GRP-IT" -GroupCategory Security -GroupScope Global -Path "OU=IT,DC=corp,DC=local"
New-ADGroup -Name "GRP-ACCOUNTING" -GroupCategory Security -GroupScope Global -Path "OU=ACCOUNTING,DC=corp,DC=local"
New-ADGroup -Name "GRP-HR" -GroupCategory Security -GroupScope Global -Path "OU=HR,DC=corp,DC=local"
New-ADGroup -Name "GRP-FINANCE" -GroupCategory Security -GroupScope Global -Path "OU=FINANCE,DC=corp,DC=local"

# Add users to their respective groups
# 1. IT Group
$itUsers = Get-ADUser -Filter * -SearchBase "OU=IT,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP-IT" -Members $itUsers

# 2. Accounting Group
$accUsers = Get-ADUser -Filter * -SearchBase "OU=Accounting,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP-Accounting" -Members $accUsers

# 3. HR Group
$hrUsers = Get-ADUser -Filter * -SearchBase "OU=HR,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP-HR" -Members $hrUsers

# 4. Operations Group
$finUsers = Get-ADUser -Filter * -SearchBase "OU=FINANCE,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP-finance" -Members $finUsers