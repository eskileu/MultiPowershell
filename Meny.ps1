##               
# MENY        
# Author: Eskil Ugelstad
# Last change: 03.10.2011
##


# Hent inn moduler vi skal bruke
Import-Module ActiveDirectory

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