<#  
       
.NOTES
 Version:        1.1
 Author:         David Boyett
 Files:          CollectV6vcsLogs.ps1
 Creation Date:  10/3/2016
 email:          David.Boyett@Brother.com
 Change Log: Switched from using 7zip to native compression

.SYNOPSIS
Copies required scripts for documentation and reporting

.DESCRIPTION
This script copies the following logs and puts them in the user documents folder: vcs.log, vcs_https.log, vcs_access.log, vcs_traceroute.log, vcs_xml_intercall.log, convert2Pdf.log, vcs_proxy.log, and vcs_sipclient.log

.PARAMETER <Parameter_Name>
None

.INPUTS
None

.OUTPUTS
None
  
.EXAMPLE
<Example goes here. Repeat this attribute for more than one example>
#>

#-----------[Initialisations]--------------------------------------------------------




#-----------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.1"


#-----------[Functions]------------------------------------------------------------


Function GetUserName
{
<#
    .DESCRIPTION
        Returns the username
 
    .PARAMETER  < parameter name >
        None 
 
#>    
    $UserName = [Environment]::UserName
    Return $UserName              
  
}
#===============================================================================================================================================

Function GetServerName
{
<#
    .DESCRIPTION
        Returns the host name
 
    .PARAMETER  < parameter name >
        None
   
#>    
    $ServerName = [Environment]::MachineName
    #Convert to lower case
    $Servername = $ServerName.ToLower()
    Return $ServerName              
  
}
#===============================================================================================================================================

Function TestPath([string]$ChkFile) # Test if log file exits
{
    <#
    .DESCRIPTION
        Checks to see if a file exists
 
    .PARAMETER  < parameter name >
        < >
   
    .EXAMPLE
        None
    #>    

    $FileExists = Test-Path $ChkFile
    If ($FileExists -eq $True) 
    {
        # If file exists call function to copy file
        CopyLogFile $ChkFile $FolderPath
    }
    Else
    {
        Write-Host "ERROR: $ChkFile does not exist" -ForegroundColor Red
        
    }
   
    
}

#===============================================================================================================================================

Function CopyLogFile([string]$FileToCopy,[string]$FolderPath)
{
    <#
    .DESCRIPTION
        < function descrtion >
 
    .PARAMETER  < parameter name >
        < parameter descrtiption >
   
    .EXAMPLE
        < example >
    #>    
    Copy-Item $FileToCopy $FolderPath
}

#===============================================================================================================================================
Function VerifyFileCopy([string]$ChkFile) # Test if log file exits
{
    <#
    .DESCRIPTION
        < function descrtion >
 
    .PARAMETER  < parameter name >
        < parameter descrtiption >
   
    .EXAMPLE
        < example >
    #>    

    $FileExists = Test-Path $ChkFile
    If ($FileExists -eq $True) 
    {
        # If file exists call function to copy file
        Write-Host "Copy Successful: " -ForegroundColor Green -NoNewLine; Write-Host $ChkFile
    }
    Else
    {
        Write-Host "ERROR: $ChkFile does not exist" -ForegroundColor Red
        
    }
   
    
}


#==================================================================================================================================
#-----------------------------------------------------------[Execution]------------------------------------------------------------
#==================================================================================================================================

Write-Host `n"Version "$ScriptVersion

# Get username
$UserName = GetUserName

# Get server name
$ServerName = GetServerName

# Get the date folder name
$Date = Get-Date -f 'ddMMyyyy'

# Get date for file names

$LogFileDate = Get-Date -f 'yyyyMMdd'
Write-Host "LogFileDate = "$LogFileDate


# Create folder path and create a folder on user desktop to store log files for compression
$FolderPath = "c:\users\$UserName\Desktop\$ServerName-$Date"

# If desktop folder does not exist create it
if(!(Test-Path $FolderPath))
{
    New-Item -ItemType directory -Path $FolderPath
    Write-Host `n`n
}

 
# Copy required logs to temporary folder created above
# NEED TO TEST TO SEE IF LOG EXISTS
# ADD ERROR HANDLING
$VcsLogPath = "c:\Program Files (x86)\Brother\Omnijoin\vcs\logs"
$SipLogPath = "c:\Program Files (x86)\Brother\Omnijoin\vcs\SipLogs"

$VcsLog = $VcsLogPath +"\vcs.log"
$VcsHttpLog = $VcsLogPath +"\vcs_http_$LogFileDate.log"
$VcsAccessLog = $VcsLogPath +"\vcs_access_$LogFileDate.log"
$VcsTracerouteLog = $VcsLogPath +"\vcs_traceroute.log"
$VcsXmlIntercallLog = $VcsLogPath +"\vcs_xml_intercall_$LogFileDate.log"
$Convert2PdfLog = $VcsLogPath +"\Convert2Pdf.log"
$VcsProxyLog = $SipLogPath +"\vcs.proxy.log"
$VcsSipclientLog = $SipLogPath +"\vcs_sipclient.log"
$VcsElLog = $VcsLogPath +"\vcs.el"

# Test to see if log file exists and copy file to desktop folder
TestPath $VcsLog
TestPath $VcsHttpLog
TestPath $VcsAccessLog
TestPath $VcsTracerouteLog
TestPath $VcsElLog
TestPath $VcsXmlIntercallLog
TestPath $Convert2PdfLog
TestPath $VcsProxyLog
TestPath $VcsSipclientLog

# Verify files were copied
$VcsLogTest = $FolderPath +"\vcs.log"
VerifyFileCopy $VcsLogTest
$VcsHttpLogTest = $FolderPath +"\vcs_http_$LogFileDate.log"
VerifyFileCopy $VcsHttpLogTest
$VcsAccessLogTest = $FolderPath +"\vcs_access_$LogFileDate.log"
VerifyFileCopy $VcsAccessLogTest
$VcsTracerouteLogTest = $FolderPath +"\vcs_traceroute.log"
VerifyFileCopy $VcsTracerouteLogTest
$VcsElLogTest = $FolderPath +"\vcs.el"
VerifyFileCopy $VcsElLogTest
$VcsXmlIntercallLogTest = $FolderPath +"\vcs_xml_intercall_$LogFileDate.log"
VerifyFileCopy $VcsXmlIntercallLogTest
$Convert2PdfLogTest = $FolderPath +"\Convert2Pdf.log"
VerifyFileCopy $Convert2PdfLogTest
$VcsProxyLogTest = $FolderPath +"\vcs.proxy.log"
VerifyFileCopy $VcsProxyLogTest
$VcsSipclientLogTest = $FolderPath +"\vcs_sipclient.log"
VerifyFileCopy $VcsSipclientLogTest

$FilePath = 'c:\Program Files (x86)\Brother\OmniJoin\vcs\SipLogs'

# Create empty array to store file names that have the current date
$MyArray = @()

$Count = 0

# Search the SipLog folder for logs with the current date and place them in an array
foreach ($file in Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()})
{
    # Add the file to the array
    $MyArray+=$file  
    $CopyFile = $MyArray[$Count]
    # Create the path to the file to copy
    $CopyFilePath = $SipLogPath +"\$CopyFile"
    # Call the function to copy the file to the desktop folder
    CopyLogFile $CopyFilePath $FolderPath
    $Count ++
    
}



<# Create alias for 7z
if (-not (test-path "$env:C:\Program Files\7-Zip\7z.exe")) {throw "$env:Program Files (x86)\7-Zip\7z.exe needed"} 
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"

# Zip the folder
sz a -t7z "$FolderPath" "$FolderPath"
#>
# Zip the folder holding the log files

#$Source = 
$Destination = $FolderPath + "\test.zip"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::CreateFromDirectory($FolderPath, $Destination)



