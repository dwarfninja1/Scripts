#RCOPY.PS1

$src, $dst = 0
Clear-Host
Add-Type -AssemblyName System.Windows.Forms

$frm = New-Object System.Windows.Forms.Form
$frm.size = New-Object System.Drawing.Size(400, 300)
$frm.text = "Robocopy"
$frm.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual

$frm.Location = new-object System.Drawing.Point(800, 0)
$frm.MaximizeBox = $false
$lbl1 = new-object System.Windows.Forms.Label
$lbl1.text = "Source"
$lbl1.top = 50
$lbl1.left = 50
$lbl1.Width = 200

$lbl2 = New-Object System.Windows.Forms.Label
$lbl2.text = "Destination"
$lbl2.top = 120
$lbl2.left = 50
$lbl2.Width = 200

$sourcetext = new-object System.Windows.Forms.TextBox
$sourcetext.top = 80
$sourcetext.left = 50

$sourcetext.Width = 300

$desttext = New-Object System.Windows.Forms.TextBox
$desttext.top = 150
$desttext.left = 50
$desttext.Width = 300

$copybutn = new-object System.Windows.Forms.Button
$copybutn.top = 180
$copybutn.left = 150
$copybutn.text = "Start"
$copybutn.Width = 100


$frm.Controls.add($lbl1)
$frm.Controls.add($lbl2)
$frm.Controls.add($sourcetext)
$frm.Controls.add($desttext)
$frm.Controls.add($copybutn)

$exec = {
    
    if (($sourcetext.text -ne ""
    ) -and ($desttext.text -ne "")) {
        if ((test-path $sourcetext.text.ToString()) -and (test-path $desttext.text.ToString())) {
            $src = Get-ChildItem $sourcetext.text -recurse -ErrorAction SilentlyContinue | Measure-Object -property length -sum
            $src = $src.sum

            #$runcmd=”Robocopy”
            $info = new-object System.Diagnostics.ProcessStartInfo
            $info.FileName = "Robocopy.exe"
            $info.Arguments = "$($sourcetext.text.ToString()) $($desttext.text.ToString()) /E /ZB /DCOPY:T /COPYALL /R:1 /W:1  /LOG:c:\Robocopy.log"
            $info.UseShellExecute = $false
            $info.CreateNoWindow = $false
            $cmd1 = [System.Diagnostics.Process]::Start($info)
            $clk = [system.diagnostics.stopwatch]::startNew()
            while (Get-Process -Name $cmd1.ProcessName -ErrorAction SilentlyContinue) {
                $clksec = [math]::Round(($clk.ElapsedMilliseconds / 1000))
                $dst = Get-ChildItem $desttext.Text -recurse -ErrorAction SilentlyContinue | Measure-Object -property length -sum
                $dst = $dst.sum
                [double]$exttme = [math]::Round(($clksec / $dst) * $src)
                try {
                    $dd = [timespan]::FromSeconds($exttme)
                }
                catch
                {}
                $dd = ”$($dd.Hours):$($dd.Minutes):$($dd.Seconds)”
                $prog = $dst / $src * 100
                $prog = [math]::Round($prog)
                #write-host "Total $($prog) % done” -ForegroundColor Green -BackgroundColor White
                write-progress -Activity "copying from $($sourcetext.text) to $($desttext.text) and Estimated time left in hh:mm:ss $($dd)" -PercentComplete $prog -Status "$prog % completed”

            }
            $clk.Stop()
            write-host "All copied, check c:\robocopy.log and total time taken $($clksec) seconds" -ForegroundColor Green
            $frm.dispose()
        }
        else {
            write-host "check source or destination path"
            $frm.dispose()
        }
    }
    else {
        write-host "check source or destination path"
        $frm.dispose()
    }

}
$copybutn.add_click($exec)
$rt = $frm.ShowDialog()
$frm.Dispose()

 