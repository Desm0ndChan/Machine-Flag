$HOSTNAME="HOST" #Hostname need to be non-existing record in server
$ALIAS="ALIASNAME"
$ZONENAME="DOMAIN"

Add-DnsServerResourceRecordCName -Name $HOSTNAME -HostNameAlias $ALIAS -ZoneName $ZONENAME -PassThru