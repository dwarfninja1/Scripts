function AutoRobocopy {
    [CmdletBinding()]
    param ([string]$LogSource,
    [string]$templogdir,
    [string]$DestHost,
    [string]$DestShare,
    [string]$DestPathSelected
    )

}
        
    
   


# Source Variables
$LogSource  = 'C:\LogFiles\RoboLogs'
$TempLogDir = 'C:\temp'

# Destination variables
$DestHost   = '\\gfraser-desk\'
$DestShare  = '\\gfraser-desk\F$\Users\Default'

# Operating Variables
$Switches   = @("/s", "/MOVE", "/zb", "/R:0", "/W:0", "/MT:8", "/NFL", "/NDL", "/NP", "/IS", "/IT")
$RoboDo     = @("$TempLogDir","\\$DestHost\$DestShare","$Switches")

# Verify event log source exists and create it if it does not
if (-not ([System.Diagnostics.EventLog]::SourceExists("PowerShell Script"))) {
    New-EventLog -LogName 'Application' -Source 'PowerShell Script'
    Write-EventLog -LogName 'Application' -Source 'Powershell Script' -EventID 1 -EntryType Information -Message 'Created new Event Log: Application Source type: PowerShell Script'
}

# Write log for init
Write-EventLog -LogName 'Application' -Source 'Powershell Script' -EventID 1 -EntryType Information -Message 'The scheduled task to move logs to the log server has been triggered and will now execute.'

# Verify Local LogDir exists
if (!(Test-Path -Path $TempLogDir)) {
    New-Item -ItemType directory -Path $TempLogDir
} 

# De-nest logs to local log folder in preparation to move
Get-ChildItem -Path $LogSource | Get-ChildItem | Get-ChildItem | Move-Item -Destination "$TempLogDir" -Force
Write-EventLog -LogName 'Application' -Source 'Powershell Script' -EventID 1 -EntryType Information -Message "Files locally de-nested into $TempLogDir."

# Remove all empty directories with unicorn glitter
Get-ChildItem $LogSource -Recurse | Where-Object {$_.PSIsContainer -and @(Get-ChildItem -LiteralPath:$_.FullName).Count -eq 0} | Remove-Item -Confirm:$false -Force
Get-ChildItem $TempLogDir -Recurse | Where-Object {$_.PSIsContainer -and @(Get-ChildItem -LiteralPath:$_.FullName).Count -eq 0} | Remove-Item -Confirm:$false -Force
Write-EventLog -LogName 'Application' -Source 'Powershell Script' -EventID 1 -EntryType Information -Message "Files locally deleted from $TempLogDir."

# Begin Robocopy operation
#$dest = "\\" + $desthost + "\" + $DestShare
robocopy $TempLogDir $DestShare $Switches
Write-EventLog -LogName 'Application' -Source 'Powershell Script' -EventID 1 -EntryType Information -Message "The scheduled task to move logs to the log server has been completed and the files were successfully copied to $DestHost."


