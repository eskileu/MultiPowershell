do
{
    $valg=""

    Write-Host ""
    Write-Host "-*- IP Velgeren -*-" 
    Write-Host "1. Nettverkslabben (Statisk IP)" 
    Write-Host "2. Hjemme (Statisk IP)"
    Write-Host "3. DHCP"
    Write-Host "4. Avslutt"
    $valg = Read-Host "Velg ønsket IP innstillinger: "

    $NIC = gwmi Win32_NetworkAdapterConfiguration -Filter Index=7


	if ($valg -match "1")
	{
		$ip = Read-host
		write-host = "Skriv inn ipadresse på formen x.x.x.x"
		$NIC.EnableStatic($ip, "255.255.255.0") 
		$NIC.SetGateways("158.38.56.1")
		$DNSServers = "158.38.56.10"
		$NIC.SetDNSServerSearchOrder($DNSServers)
		$NIC.SetDynamicDNSRegistration("TRUE")
		
	}elseif ($valg -match "2")
	{
		$NIC.EnableStatic("192.168.1.21", "255.255.255.0") 
		$NIC.SetGateways("192.168.1.1")
		$DNSServers = "192.168.1.1"
		$NIC.SetDNSServerSearchOrder($DNSServers)
		$NIC.SetDynamicDNSRegistration("TRUE")    
	}elseif ($valg -match "test3")
	{
		$NIC.EnableDHCP()
		$NIC.SetDNSServerSearchOrder()    
	}elseif ($valg -match "4")
	{
		Write-Host "ByeBye!" -ForegroundColor Red
	}

	# Restarter NIC om det blir gjort valg i menyen som fører til endringer
	if($valg -notmatch "4"){
		$adapter = gwmi -Class Win32_NetworkAdapter -Filter Index=7
		$adapter.disable()
		$adapter.enable() 
	}

	Get-WmiObject Win32_NetworkAdapterConfiguration | Where {$_.Index -match "7"}
	(ipconfig | findstr [0-9].\.)[0]
	
}until ($valg -eq "4")