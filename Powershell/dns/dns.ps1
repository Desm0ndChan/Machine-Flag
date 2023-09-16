# Set static variables
$domainName = "yourdomain.com" #Change this
$domainNetBiosName = "YOURDOMAIN" #Change this
# Subdomains array
$subdomains = @("sub1", "sub2", "sub3") #Change this

# Import required Server Manager module
Import-Module ServerManager

Add-WindowsFeature DNS -IncludeManagementTools

# Import the DnsServer module for the PowerShell
Import-Module DnsServer

foreach ($subdomain in $subdomains) {
    Add-DnsServerPrimaryZone -Name "$subdomain.$domainName" -ReplicationScope Forest
}

# Enable zone transfer to any server
Set-DnsServerPrimaryZone -Name $ZoneName -SecureSecondaries TransferAnyServer