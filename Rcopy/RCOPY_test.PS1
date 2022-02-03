#Backup_AutoScheduling_test.PS1

get-date | out-file "F:\backuplogs\Log_Backup.txt" - Append
Get-PSDrive -Ps