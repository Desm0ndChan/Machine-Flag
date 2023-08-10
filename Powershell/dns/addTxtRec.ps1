$ZONENAME="DOMAIN"
$NAME="HOSTNAME"
$CONTENT="CONTENT"
Add-DnsServerResourceRecord -ZoneName $ZONENAME -TXT -Name $NAME -DescriptiveText $CONTENT