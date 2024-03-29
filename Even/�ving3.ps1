import-module ActiveDirectory
Add-PSSnapin quest.activeroles.admanagement

# GOGO ADMANAGEMENT

#Sjekker om objektet finnes
function Test-QADObject {
param($Identity)

(Get-QADObject $Identity -DontUseDefaultIncludedProperties `
 -WarningAction SilentlyContinue -ErrorAction SilentlyContinue `
 -SizeLimit 1) -ne $null
}

Clear

$domene= 'OU=script,DC=vmdom,DC=local' #Må byttes til din lokale lekeplass
$objDomain = [ADSI]"LDAP://ou=script,dc=vmdom,dc=local" #Se over

$sporsmal = Read-Host "Skal du bruke en underou?"

if ($sporsmal -match "ja"){
    do {
    $underOU = ""
    $tempDomene = $domene
   
    $underOU= Read-Host "navn?"
    $underOU= 'OU=' + $underOU + ","
    $tempDomene= $underOU + $tempDomene
    $sjekk= test-qadobject $tempDomene
   
    if ($sjekk -match "False") {
    write-host "Ouen du skal legge under inn eksisterer ikke DRATELHÆLVETE"
    }
  }while($sjekk -match "False")
  $domene = $tempDomene
  $hjelpevar2 = "LDAP://" + $domene
  $objDomain = [ADSI]$hjelpevar2
}


Do{

$StrOUName = Read-Host "Gi et navn til din ou"
$hjelpevar = 'OU=' + $StrOUName + "," + $domene
$sjekk = Test-QADobject $hjelpevar

    If  ($sjekk -match "True"){
       write-host "Ouen eksisterer, skriv på nytt"
    }
}While  ($sjekk -match "True")

$objOU = $objDomain.Create("OrganizationalUnit", "ou=" + $StrOUName)
$objOU.SetInfo()

Write-Host $StrOUName "Laget"

If($sporsmal -match "ja"){
    $items2 = Get-QADObject -Type OrganizationalUnit | where{$_.DN -match $domene}
   
    write-host "Følgende ouer ligger i ouen som er valgt (Første innslag er valgte)"
    write-host ""
   
    Foreach($i in $items2){
    write-host $i.Name
    }
}
elseif ($sporsmal -match "fillern"){
write-host "Syntes du er litt grov jeg nå"
}
else{
write-host "Ou lagt på roten"
}
