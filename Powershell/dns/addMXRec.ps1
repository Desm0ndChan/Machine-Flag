$HOSTNAME="HOST"
$MXSERVER="MXSERVERNAME"
$ZONENAME="DOMAIN"
$PREFERENCE="NUMBER"
Add-DnsServerResourceRecordMX -Name $HOSTNAME -MailExchange $MXSERVER -ZoneName $ZONENAME -Preference $PREFERENCE -PassThru