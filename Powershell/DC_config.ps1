# Set static variables
$domainName = "yourdomain.com" #Change this
$safeModeAdminPassword = ConvertTo-SecureString -String "YourSafeModePassword" -AsPlainText -Force #Change this
$domainNetBiosName = "YOURDOMAIN" #Change this

# Subdomains array
$subdomains = @("sub1", "sub2", "sub3") #Change this

# Import required Server Manager module
Import-Module ServerManager

# Install the necessary roles and features for Active Directory
# Note that this may require a restart
Add-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools

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

# Import the DnsServer module for the PowerShell
Import-Module DnsServer

# Generate the 25 bytes hash value
$flag = Get-Random | Out-String | Get-FileHash -Algorithm MD5 | ForEach-Object {$_.Hash.Substring(0, 25)}

# Add TXT record to DNS
Add-DnsServerResourceRecord -Txt -DescriptiveText $flag -Name "flag" -ZoneName $domainName #Change this

# Adding subdomains
foreach ($subdomain in $subdomains) {
    Add-DnsServerPrimaryZone -Name "$subdomain.$domainName" -ReplicationScope Forest
}

# Enable zone transfer to any server
Set-DnsServerPrimaryZone -Name $domainName -TransferToAnyServer $true

# Enable Windows Remote Management (WinRM)
Enable-PSRemoting -Force

# Enable Remote Desktop Protocol (RDP)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

# Restart the server to apply changes
Restart-Computer -Force
