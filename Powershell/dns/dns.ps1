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