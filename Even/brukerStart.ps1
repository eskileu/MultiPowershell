####################
#     Even ja.     #
#     Hjelpes!     #
# Work in progress #
####################
#Last edited by even 11:15 20.10.2011
#Setter domenet
$domene = "OU=script,DC=hjemmedom,DC=local"

#Legger inn domene og sti til ou'en som brukeren skal ligge i
$userContainer = [adsi]"LDAP://OU=script,DC=hjemmedom,DC=local"

import-module activedirectory -ErrorAction silentlycontinue

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

#Adminsjekk.(Satt på vent)
<#
do{
$navn = [Environment]::UserName
    if($navn -match "Administrator"){
    write-host "Du er admin(HURRA)"    
    }else{
    write-host "logg inn som admin"
    $cred = Get-credential "Administrator"
    
    }
    if($cred -eq $null){
    write-host "Neivel"
    return
    }
}while ($navn -notmatch "Administrator")
#>


#angi bane til csv
# [string]$sti = read-host "Angi banen til csv!!?"
$sti = "C:\script\git\Even\burker.csv" #Midlertidig statisk

[string]$passord = "even1234:E"
[object]$bruker = import-csv $sti

#Bruker tesdel:
foreach ($i in $bruker){
[string]$fornavn = $i.fornavn
[string]$etternavn = $i.etternavn

#Bruker $f som teller for fornavn og $e for etternavn
$f = 2
$e = 3
    
#Genererer brukernavn, utvider fornavn først så etternavn.
    do{        
        if(($f -eq $fornavn.Length) -and ($e -eq $etternavn.Length)){
        #Hva om hele navnet er opptatt?
        $f =3
        $e =2
            do{
             
                    if(($f -eq $fornavn.Length) -and ($e -eq $etternavn.Length)){
                    write-host "lolwut"
                    return
                    }
                    elseif($e -eq $etternavn.length){
                        #Hva med $f++? :(
                        $f = $f+1
                    }
                    else{
                        #ingen $e++ :(
                        $e = $e + 1
                    }
             $brukernavn = ($fornavn.substring(0,$f) + $etternavn.substring(0,$e))       
             $navnhjelp = test-ADnavn($brukernavn)
            }while($navnhjelp)
            
        
        }
        elseif($f -eq $fornavn.Length){
        #ingen $e++ :(
        $e = $e + 1
        }
        else{
        #Hva med $f++? :(
        $f = $f+1
        }
     $brukernavn = ($fornavn.substring(0,$f) + $etternavn.substring(0,$e))
     $navnhjelp = test-ADnavn($brukernavn)
    }while($navnhjelp)

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
    
    $newUser = $userContainer.Create("User","CN=$brukernavn")
    $newUser.Put("samAccountName", "$brukernavn")
    $newUser.SetInfo()
    $newUser.psbase.Invoke("SetPassword", "$passord")

    #Enabler brukerkonto
    $newUser.psbase.InvokeSet('AccountDisabled', $false)
    $newUser.SetInfo()

#Setter at bruker må skifte passord ved førstagangs innlogging
    $newUser.Put("pwdLastset",0)
    $newUser.setinfo()
   write-host $brukernavn
}

#Note to self: http://www.gifsforum.com/images/gif/did%20not%20read/grand/didnt_read_dance_gif.gif



