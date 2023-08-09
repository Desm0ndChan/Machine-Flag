$HOSTNAME="HOST"
$ALIAS="ALIASNAME"
$ZONENAME="DOMAIN"

Add-DnsServerResourceRecordCName -Name $HOSTNAME -HostNameAlias $ALIAS -ZoneName $ZONENAME -PassThru