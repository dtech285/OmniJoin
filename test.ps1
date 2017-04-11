$FilePath = 'c:\Program Files (x86)\Brother\OmniJoin\vcs\SipLogs'
#$Result = Get-ChildItem $FilePath

#[string[]]$MyArray = ""
$MyArray = @()
$My2ndArray = @()
$Count = 0
<#
foreach ($file in Get-ChildItem $FilePath)
{
    #Write-Host "Count = " $Count
    $MyArray+=$file  
    Write-Host $Count ") " $MyArray[$Count]
    $Count ++
    
}
#>
$Count2 = 0
Write-Host `n`n"###################################################"`n
foreach ($file in Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()})
{
    #Write-Host "Count = " $Count
    $My2ndArray+=$file  
    Write-Host $Count2 ") " $My2ndArray[$Count2]
    $Count2 ++
    
}

#$Time = Get-Date -Format MM/dd/yyyy
#$Time = Get-Date
#Write-Host "Date = " $Time

#$Files = Get-ChildItem $FilePath -Recurse | Where-Object {$_.LastWriteTime -eq $Time}
#$Files = Get-ChildItem $FilePath | Where-Object {$_.Length -gt 0KB} # WORKS!!
#$MoreFiles = Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime -eq (Get-Date)}


<#
Write-Host "###################################################"
Write-Host "-gt"
Get-ChildItem $FilePath | Where{$_.LastWriteTime -gt (Get-Date).AddDays(+.5)}

Write-Host "###################################################"
Write-Host "-ge"
Get-ChildItem $FilePath | Where{$_.LastWriteTime -ge (Get-Date).AddMinutes(-300)}

Write-Host "###################################################"`n
Write-Host "-lt"
Get-ChildItem $FilePath | Where{$_.LastWriteTime -lt (Get-Date)}
#>

# ********************************************************************************************
#                                        BELOW WORKS
# ********************************************************************************************
Write-Host `n`n"###################################################"
Write-Host "You can compare the current date against the date part only of each file LastWriteTime short date:"
<#Get-ChildItem -Path C:\temp\ftp\archive -Recurse | Where-Object  {
   $_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString() 
}#>

<#
Get-ChildItem $FilePath | Where-Object  {
   $_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString() 
}#>
Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()}