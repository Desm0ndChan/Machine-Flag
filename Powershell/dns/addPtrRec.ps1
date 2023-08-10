$HOSTNAME="HOSTNAME"
$DOMAIN_NAME="DOMAIN"
$IP="192.168.1.1"
Add-DnsServerResourceRecordA -Name $HOSTNAME -ZoneName $DOMAIN_NAME -IPv4Address $IP -TimeToLive 01:00:00 -CreatePtr -PassThru
Get-DnsServerResourceRecord -ZoneName $DOMAIN_NAME | Format-Table -AutoSize -Wrap