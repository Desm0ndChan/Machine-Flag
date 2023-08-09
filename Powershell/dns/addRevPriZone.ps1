$NetID="192.168.2.0/24"
$ZoneFile="2.168.192.in-addr.arpa.dns"
Add-DnsServerPrimaryZone -NetworkID $NetID -ZoneFile $ZoneFile -DynamicUpdate None -PassThru
Get-DnsServerZone