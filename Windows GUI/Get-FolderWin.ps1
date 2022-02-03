

[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')



Function Get-Folder($initialDirectory) {
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') 
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog 
    $FolderBrowserDialog.RootFolder = 'Desktop'
    if ($initialDirectory) { $FolderBrowserDialog.SelectedPath = $initialDirectory }
    [void] $FolderBrowserDialog.ShowDialog()
    return $FolderBrowserDialog.SelectedPath
    #$FolderPermissions = $FolderBrowserDialog.SelectedPath
    
}
($FolderPermissions = Get-Folder $FolderBrowserDialog.SelectedPath | get-acl | Select-Object -exp access | Format-Table) 
#($FolderPermissions = Get-Folder $FolderBrowserDialog.SelectedPath)

function Get-File($initialDirectory) {   
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    if ($initialDirectory) { $OpenFileDialog.initialDirectory = $initialDirectory }
    $OpenFileDialog.filter = 'All files (*.*)|*.*'
    [void] $OpenFileDialog.ShowDialog()
    return $OpenFileDialog.FileName
}
($FilePermissions = Get-File C:\ | get-acl | Select-Object -exp access | Format-Table)
