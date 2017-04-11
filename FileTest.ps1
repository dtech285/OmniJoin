$Time = (Get-Date)
Get-ChildItem 'C:\Program Files (x86)\Brother\Omnijoin\VCS\SipLogs' -Recurse | Where-Object {$_LastWriteTime -lt $Time}


$RemotePath = "C:\Program Files (x86)\Brother\Omnijoin\VCS\SipLogs"
$LocalPath = "C:\users\dboyett\desktop"

#$Max_days = "-1"
#Max_mins = "-5"
$Curr_date = get-date -Format MMddyyyy
Write-Host "Current date = "$Curr_date 

#Checking date and then copying file from RemotePath to LocalPath
Foreach($file in (Get-ChildItem $RemotePath))
{
    Write-Host `n"File.LastWriteTime = "$file.LastWriteTime
    if($file.LastWriteTime -eq ($Curr_date))
    {

        Copy-Item $file $LocalPath 
        
    }
    ELSE
    {
        Write-Host "not copying $file"
        
    }

}
    