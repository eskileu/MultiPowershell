$dc = Get-ADDomain | select DistinguishedName
$dc = $dc -creplace "@{DistinguishedName=", "" -creplace "}", "" -creplace "DC", "dc"

write-host $dc






