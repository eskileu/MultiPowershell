#Oppretter fila og eventuelt rensker fila som ligger der.
write-host = ""| Out-File C:\adsvarfil.txt
Write-Host = "installer AD + DNS, lager svarfil på C:"
write-host = ""

$domene = Read-Host "skriv inn domene"
write-host = "" 

$dombiosname = Read-Host "skriv inn Domain Net Bios Name"
write-host = ""

$4 = "NewDomainDNSName = " + $domene + " DomainNetBiosName = " + $dombiosname
write-host = ""

$safemodepass= Read-Host "Skriv inn SafeModeAdminPassword"
$7 = "SafeModeAdminPassword =" + $safemodepass
write-host = ""
$1 = "[DCINSTALL]" >> C:\adsvarfil.txt
$2 = "ReplicaOrNewDomain = Domain" >> C:\adsvarfil.txt
$3 = "NewDomain = Forest" >> C:\adsvarfil.txt
$4 >> C:\adsvarfil.txt
$5 = "InstallDNS = yes" >> C:\adsvarfil.txt
$6 = "RebootOnCompletion = Yes" >> C:\adsvarfil.txt
$7 >> C:\adsvarfil.txt

Write-Host = "Installerer AD + DNS"
dcpromo /unattend:C:\adsvarfil.txt