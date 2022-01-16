<#

.SYNOPSIS
  Powershell script to ping all IP addresseses in a CSV file.
  
.DESCRIPTION
  This PowerShell script reads a CSV file and pings all the IP addresses listed in the IPAddress column.
  
.PARAMETER <csvfile>
   File name and path of the CSV file to read.
 
.NOTES
  Version:        1.0
  Author:         
  Creation Date:  12-Jan-2017
 
.LINK
   
    
.EXAMPLE
 # Ping-IPList #
   


Param(
  [Parameter(Mandatory=$true, position=0)][string]$csvfile
)
<#
#>

$RootDir = $PSScriptRoot

$ColumnHeader = "IPaddress" 

Get-ChildItem -Path $RootDir -Filter "*.csv"   


$csvfile = Read-Host "Enter CSV filename: default 'IPaddress.csv' "
if ($csvfile -ne "") {
    $csvFile = $RootDir + "\" + $csvfile
    Write-Host "Reading file" $csvfile
}
else {
    $csvfile = $RootDir + "\" + "IPaddress.csv"
}
$ipaddresses = import-csv $csvfile | select-object $ColumnHeader

$Logname = "Log.txt"
$Location = $RootDir
$logfile = New-Item -Path $Location -Name $Logname -ItemType File -Force


#$logfile = New-Item -ItemType File -Path $RootDir + "\" + "Log.txt"
Write-Host $logfile
Write-Host "Started Pinging.."

foreach ( $ip in $ipaddresses) {

  if (test-connection $ip.("IPAddress") -count 1 -quiet) {
        write-host $ip.("IPAddress") "Ping succeeded." -foreground green 

    }
    else {
        write-host $ip.("IPAddress") "Ping failed." -foreground red 
    }
}


Write-Host "Pinging Completed."

