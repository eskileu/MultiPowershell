<#
.SYNOPSIS
    Remoting script.

.DESCRIPTION   
    Bruk enable-psremoting på hosten & klient
    Bruk winrm s winrm/config/client '@{TrustedHosts=" IP HER "}' på klienten
    For bruk av ssl gjør du følgende: run mmc og add certificate legg til fw
    regler (Dette gjøres ikke default)
#>

function remoteVM{
[cmdletbinding()]
param(
 [parameter(position=0,mandatory=$false)]
 [string]$hvor
)
process{
Write-host " Bruk enable-psremoting på hosten & klient
    Bruk winrm s winrm/config/client '@{TrustedHosts=" IP HER "}' på klienten
    For bruk av ssl gjør du følgende: run mmc og add certificate legg til fw
    regler (Dette gjøres ikke default)"
Write-host "Trykk ANYKEY for å fortsette"
read-host    

    
 #if($hvor -match "skole"){
 #$ip = "158.38.56.179"
 #$bruker = "3badr-gr3.testlab.aitel.hist.no\administrator"
 #}

 #elseif($hvor -match "vmdom"){
 #$ip = "192.168.190.5"
 #$bruker = "vmdom.local\administrator"
 #}

 #else{
 $ip = read-host "skriv ip"
 $bruker = read-host "domene\brukernavn"
 #}

 $session = New-PSsession –ComputerName $ip -credential $bruker # -port 5986 -useSSL
 Enter-PSsession -session $session
 }
}