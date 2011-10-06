####################
#     Even ja.     #
#     Hjelpes!     #
# Work in progress #
####################

#Last edited by even 00:00 06.10.2011
import-module activedirectory

#Returnerer true om brukernavnet er i bruk
function Test-ADnavn {
param($Identity)

(Get-ADuser -filter *| where{$_.SamAccountName -like $Identity} ) -ne $null
}

#returnerer true om ouen eksisterer
function test-ADou{
param($ou)
(Get-ADobject -filter 'objectClass -like "organizationalUnit"' | where{$_.Name -like $ou}) -ne $null
}

#angi bane til csv
# [string]$sti = read-host "Angi banen til csv!!?"
[string]$sti = "C:\script\git\Even\burker.csv" #Midlertidig statisk

[string]$passord = "even123"
[object]$bruker = import-csv $sti

#Bruker tesdel:
foreach ($i in $bruker){
[string]$fornavn = $i.fornavn
[string]$etternavn = $i.etternavn

[string]$brukernavn = ($fornavn.substring(0,3) + $etternavn.substring(0,3))

$navnhjelp = test-ADnavn($brukernavn)
    
    while($hjelpevar -match "true"){
    #Endre $brukernavn + fornavn
    write-host "Hei"
    }
 
 #Ou testdel
 $ouhjelp = test-ADou($i.klasse)
    if($ouhjelp -match "false"){
    #dersom ou med navn $i.klasse ikke eksisterer
    #legges de under en temp ou.
    #opprettes og sjekker om den eksisterer utenfor
    #løkka over foreach
    
    write-host "temp"
    write-host $i.klasse
    }
    
   write-host $brukernavn 
}

#Note to self: http://www.gifsforum.com/images/gif/did%20not%20read/grand/didnt_read_dance_gif.gif



