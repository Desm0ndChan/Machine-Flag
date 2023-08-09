$DOMAIN="DOMAIN"
Add-DnsServerPrimaryZone -Name $DOMAIN -ZoneFile "$DOMAIN.dns" -DynamicUpdate None -PassThru
Get-DnsServerZone