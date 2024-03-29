##               
# MENY        
# Author: Eskil Ugelstad
# Last change: 03.10.2011
##


# Sjekker om ad-modulen allerede er lastet inn, ellers gjør den det.
if((get-module | where {$_.name -like "activedirectory"}) -eq $null){
import-module activedirectory -WarningAction SilentlyContinue -ErrorAction SilentlyContinue 

if  ($?){
write-host "Importert AD-Modul"
}
else{
write-host "Kunne ikke importere activedirectory"
exit
}
}
else{
write-host "Modulen alerede lastet"
}

$valg = 0
while ($valg -ne 3){
    
    #Skriv ut menyen
    Write-Host ""
    Write-Host "MultiPowershell" -ForegroundColor Green
    Write-Host ""
    Write-Host "1. AD "
    Write-Host "2. Remote"
    Write-Host "3. Avslutt"
    Write-Host "_/----^----\_" -ForegroundColor RED
    
    # Variabel til menyvalget
    $valg = Read-Host "Valgets kval"
    
    #Sjekk valg og utfør ønsket handling    
    if($valg -match "1"){
        Write-Host "Du valgte 1, doh!"
    }
    elseif ($valg -match "2"){
        Write-Host "Du valgte 2, doh!"
    }
    else{
        Clear
    }
}