#Laster inn AD modulen
write-host = "Laster in ActiveDirectory"
Import-Module activeDirectory
write-host =""
write-host ="Kobler til server"
#Henter inn navn på Main OU
$createOU = Read-Host "Skriv inn navn på main OU"

#Henter inn domene automatisk på formen dc= og fjerner unødvendige parametere.
write-host "Henter domenet på formen dc= og slanker det ned til: "
$dc = Get-ADDomain | select DistinguishedName
$dc = $dc -creplace "@{DistinguishedName=", "" -creplace "}", "" -replace "DC", "dc"
write-host $dc

# Kobler opp mot AD
$connect = "LDAP://"+ $dc
$AD = [adsi] $connect
write-host =""

#Oppretter OUen
write-host ="Oppretter OU"
$OU = $AD.Create("OrganizationalUnit", "ou="+$createOU)
$OU.SetInfo()
write-host =""

#Oppretter subOUer
write-host ="Oppretter underOU"
$connetOU = "LDAP://ou=" + $createOU + ", " + $dc
$AD = [adsi] $connetOU

#Spør bruker hvor mange subOUer du vil lage
$antallOU = read-host "Skriv inn antall sub OUer du ønsker å opprette"

#Kjører løkke som oppretter subOUer
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

#Spør bruker om han vil opprette OU for globale og lokale grupper
$a = new-object -comobject wscript.shell 
$intAnswer = $a.popup("Vil du opprette globale og lokale OUer?", 0,"Globale og Lokale OUer",4)

If ($intAnswer -eq 6) { 
     
    write-host "Yes"
    Write-Host "Oppretter OUen grupper"
    
    #Oppretter OUen grupper
    $gruppe = $bedrift.Create("OrganizationalUnit", "OU=grupper") 
    $gruppe.Put("Description","Grupper")
    $gruppe.SetInfo()
    
    $connetOU = "LDAP://ou=grupper, ou=" + $createOU + ", " + $dc
    $AD = [adsi] $connetOU
    
    #Oppretter global OU under OUen grupper for globale grupper
    $bedrift = $AD
    $avdl = $bedrift.Create("OrganizationalUnit", "ou=globale")
    $avdl.put("Description", "OU for globale grupper")
    $avdl.SetInfo()
    write-host "OU globale opprettet"
    
    #Oppretter lokal OU under OUen grupper for lokale grupper
    $avdl = $bedrift.Create("OrganizationalUnit", "ou=lokale")
    $avdl.put("Description", "OU for lokale grupper")
    $avdl.SetInfo()
    write-host "OU lokale opprettet"
} else {
    #hvis svaret om og opprette grupper er nei, opprettes det ikke noen OUer for grupper
    write-host "NO"
    write-host "Oppretter ikke grupper"   
}

write-host ""
write-host ""
write-host ""

#Henter informasjon om OUen
Write-Host -foregroundColor cyan "Informasjon om " $Ounavn ":"
$connetOU = "LDAP://ou=" + $createOU + ", " + $dc
$AD = [adsi] $connetOU
$AD | select-object ou,description,children,path | format-list

