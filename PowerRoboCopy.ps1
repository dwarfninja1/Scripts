Set-Location 'c:\users\'

&robocopy.exe 'c:\users\' 'f:\users\' /b /mt:96 /r:3 /w:3 /np /ts /bytes /xd > c:\log.txt 