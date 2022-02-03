function FindFolders ($filepath) {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = $srcpath
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a Source directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Insert your script here
        Write-Host "$loop slected."
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return "Cancel"
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 
$filepath = "C:\"
$PathSelected = FindFolders $filepath
Write-host "Path selected: $PathSelected"                     
Write-host "Program Terminated"