<#
.SYNOPSIS
    AD funksjon for bruker behandling.

.DESCRIPTION   
    Legger til brukere med hjelp av tre forskjellige metoder.
    1. Ren kommando basert. Kun en bruker om gangen
    2. Bruker en malbruker og kommandolinjen.
    3. Henter alt fra en CSV fil og smeller inn mange brukere på en gang.
#>
Function OpprettADBruker{
    [cmdletbinding()]
    param(
        [parameter(position=0,mandatory=$false)]
        [int]$i
    )
    process{
    
        
        $PASSORD = Read-Host "Angi et temp passord:" -AsSecureString
        $ADBANE  = Read-Host "Angi path du vil legge brukerene i (ou=bla,dc=norge,dc=no):"
        
        if($i -match "0"){
            Write-Host "Default"
        }
        elseif($i -match "1"){
            Write-Host "Du valgte 1, doh!"
        }
        elseif($i -match "2"){
            $MALBRUKER = Read-Host "Angi brukernavnet på malbrukeren du vil benytte: "
            $MAL = Get-ADUser -Identity $MALBRUKER
            New-ADUser alacar -Instance $MAL -AccountPassword $PASSORD -PATH $ADBANE

        }
        elseif($i -match "3"){
            $BANECSV = Read-Host "Angi den fulle banen til CSV filen (C:\blabla\min.csv):"
            Import-Csv $BANECSV | New-ADUser -AccountPassword $PASSORD -Enabled 1 -Path ‘$ADBANE’
        }else{
            Clear
        }
        
        $i = 0
    }
}