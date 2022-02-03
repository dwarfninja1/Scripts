#Daily Dump of App Log Scheduled Task.ps1

$action = New-ScheduledTaskAction -Execute 'Powershell.exe'-Argument '-NoProfile -WindowStyle Hidden -command & {get-eventlog -logname Application -After ((get-date).AddDays(-1)) | Export-Csv -Path C:\LogFiles\AppLogs\applog.csv -Force -NoTypeInformation}'

$trigger =  New-ScheduledTaskTrigger -Daily -At 9am

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "AppLog" -Description "Daily dump of Applog"