$dc = Get-ADDomain | select DistinguishedName
$dc = $dc -creplace "@{DistinguishedName=", "" -creplace "}", ""
write-host $dc






