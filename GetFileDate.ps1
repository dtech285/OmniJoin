$FilePath = 'c:\Program Files (x86)\Brother\OmniJoin\vcs\SipLogs'

# Create empty array to store file names that have the current date
$MyArray = @()

$Count = 0

# Search the SipLog folder for logs with the current date and place them in an array
foreach ($file in Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()})
{
    
    $MyArray+=$file  
    Write-Host $Count ") " $MyArray[$Count]
    # move files to folder on desktop
    $Count ++
    
}





#Write-Host "You can compare the current date against the date part only of each file LastWriteTime short date:"
#Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()}