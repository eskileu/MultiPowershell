############
# Even ja. #
# Hjelpes! #
############

import-module activedirectory

function Test-ADnavn {
param($Identity)

(Get-ADuser -filter *| where{$_.SamAccountName -like $Identity} ) -ne $null
}

#angi bane til csv
[string]$sti = "C:\script\git\Even\burker.csv"

[string]$passord = "even123"
[object]$bruker = import-csv $sti

foreach ($i in $bruker){
[string]$fornavn = $i.fornavn
[string]$etternavn = $i.etternavn

[string]$brukernavn = ($fornavn.substring(0,3) + $etternavn.substring(0,3))

$hjelpevar = test-ADnavn($brukernavn)
    
    while($hjelpevar -match "true"){
    #Endre $brukernavn + fornavn
    write-host "Hei"
    }
   write-host $brukernavn 
}
