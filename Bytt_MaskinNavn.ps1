    write-host ""
    write-host ""
    write-host "Skift maskinnavn"
    write-host ""
    write-host ""

    $Computer = Get-WmiObject Win32_ComputerSystem
    $mNavn = read-host("Skriv inn ønsket maskinnavn")
    $Computer.Rename($mNavn)
    Write-Host ("Maskinnavnet er nå blitt endret til " + $mNavn + " og trenger en restart for å fullføre bytte")