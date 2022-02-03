#Backup_AutoScheduling_test.PS1

#Powershell -NoProfile -WindowStyle Hidden -command "& {get-eventlog -logname Application -After ((get-date).AddDays(-1)) | Export-Csv -Path c:\temp\applog.csv -Force -NoTypeInformation}"

get-date | out-file F:\backuplogs\Log_Backup.txt -Append
Get-PSDrive -PSProvider FileSystem | out-file "F:\backuplogs\Log_Backup.txt" - Append

