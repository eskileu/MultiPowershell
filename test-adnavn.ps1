
function Test-ADnavn {
param($Identity)

(Get-ADuser -filter *| where{$_.SamAccountName -like $Identity} ) -ne $null
}
