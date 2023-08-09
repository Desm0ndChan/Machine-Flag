# Set static variables
$domainName = "yourdomain.com" #Change this
$safeModeAdminPassword = ConvertTo-SecureString -String "YourSafeModePassword" -AsPlainText -Force #Change this
$domainNetBiosName = "YOURDOMAIN" #Change this

# Import required Server Manager module
Import-Module ServerManager

# Install the necessary roles and features for Active Directory
# Note that this may require a restart
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Import the Active Directory module for the PowerShell
Import-Module ADDSDeployment

# Create a new AD forest
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName $domainName `
-DomainNetbiosName $domainNetBiosName `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$true `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $safeModeAdminPassword

# Enable Windows Remote Management (WinRM)
Enable-PSRemoting -Force

# Enable Remote Desktop Protocol (RDP)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

# Restart the server to apply changes
Restart-Computer -Force
