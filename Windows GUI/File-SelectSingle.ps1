#File-SelectSingle.ps1 
#File Browser Dialogue Box (Single File)

Add-Type -AssemblyName System.Windows.Forms

Function Select-File ($filename)
{
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can be chosen
	Filter = 'Images (*.jpg, *.png)|*.jpg;*.png' # Specified file types
}
 
[void]$FileBrowser.ShowDialog()

$file = $FileBrowser.FileName;

If($FileBrowser.FileNames -like "*\*") {

	# Do something 
	$FileBrowser.FileName #Lists selected files (optional)
	return $file
}

else {
    Write-Host "Cancelled by user"

}
}

#     Main
$file = Select-File $filename

$file