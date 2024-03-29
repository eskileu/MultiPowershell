write-host = "Laster in ActiveDirectory"
Import-Module activeDirectory
write-host =""
write-host ="Kobler til server"

$createOU = Read-Host "Skriv inn navn på main OU"

write-host "Henter domenet på formen dc= og slanker det ned til: "
$dc = Get-ADDomain | select DistinguishedName
$dc = $dc -creplace "@{DistinguishedName=", "" -creplace "}", "" -replace "DC", "dc"
write-host $dc

$connect = "LDAP://"+ $dc
$AD = [adsi] $connect
write-host =""
write-host ="Oppretter OU"
$OU = $AD.Create("OrganizationalUnit", "OU="+$createOU)
$OU.SetInfo()
write-host =""


write-host ="Oppretter underOU"
$connetOU = "LDAP://OU=" + $createOU + ", " + $dc
$AD = [adsi] $connetOU

$antallOU = read-host "Skriv inn antall sub OUer du ønsker å opprette"

for ($i = 1; $i-le $antallOU; $i++)
{
    $OUnavn = Read-Host "Skriv inn navnet på OU"
    $ouDesc = Read-Host "Skriv inn beskrivelsen på OU-en"
    

    $bedrift = $AD
    $avdl = $bedrift.Create("OrganizationalUnit", "ou=" + $OUnavn)
    $avdl.put("Description", $ouDesc)
    $avdl.SetInfo()
    
    
    write-host = "Opprettet OU: " + $OUnavn
}