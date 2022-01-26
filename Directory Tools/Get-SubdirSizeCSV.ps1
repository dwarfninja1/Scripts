$myDirectory = "C:\Users\gfraser"
$destcsv = $myDirectory + "\" + "subdir.csv"
New-item -Path $destcsv -itemtype file -Force
Get-ChildItem -Path $myDirectory -Recurse |`
    ForEach-Object {
    $Item = $_
    $Type = $_.Extension
    $Path = $_.FullName

    $ParentS = ($_.Fullname).split("\")
    $Parent = $ParentS[@($ParentS.Length - 2)]
    $ParentPath = $_.PSParentPath
    $ParentPathSplit = ($_.PSParentPath).split("::")
    $ParentPathFinal = $ParentPathSplit[@($ParentPathSplit.Length - 1)]
    $ParentPath = [io.path]::GetDirectoryName($myDirectory)

    $Folder = $_.PSIsContainer
    $Age = $_.CreationTime

    $Path | Select-Object `
    @{n = "Name"; e = { $Item } }, `
    @{n = "Created"; e = { $Age } }, `
    @{n = "Folder Name"; e = { if ($Parent) { $Parent }else { $Parent } } }, `
    @{n = "filePath"; e = { $Path } }, `
    @{n = "Extension"; e = { if ($Folder) { "Folder" }else { $Type } } }, `
    @{n = "Folder Name 2"; e = { if ($Parent) { $Parent }else { $Parent } } }, `
    @{n = "Folder Path";e={$ParentPath}},`
    @{n = "Folder Path 2"; e = { $ParentPathFinal } }`
}| Export-Csv $destcsv -Append -Force -NoTypeInformation