<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Files:          CollectV6vcsLogs.ps1
 Creation Date:  10/3/2016
 

.SYNOPSIS
Copies required scripts for documentation and reporting

.DESCRIPTION
This script copies the following logs and puts them in the user documents folder: vcs.log, vcs_https.log, vcs_access.log, vcs_traceroute.log, vcs_xml_intercall.log, convert2Pdf.log, vcs_proxy.log, and vcs_sipclient.log

.PARAMETER <Parameter_Name>
<Brief description of parameter input required. Repeat this attribute if required>

.INPUTS
<Inputs if any, otherwise state None>

.OUTPUTS
<Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
  
.EXAMPLE
<Example goes here. Repeat this attribute for more than one example>
#>

#-----------[Initialisations]--------------------------------------------------------




#-----------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"


#-----------[Functions]------------------------------------------------------------


Function GetUserName
{
<#
    .DESCRIPTION
        < function descrtion >
 
    .PARAMETER  < parameter name >
        < parameter descrtiption >
   
    .EXAMPLE
        < example >
#>    
    $UserName = [Environment]::UserName
    Return $UserName              
  
}
#===============================================================================================================================================

Function GetServerName
{
<#
    .DESCRIPTION
        < function descrtion >
 
    .PARAMETER  < parameter name >
        < parameter descrtiption >
   
    .EXAMPLE
        < example >
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

# Get the date
$Date = Get-Date -f 'ddMMyyyy'
$Day = Get-Date -Format dd
$Month = Get-Date -Format MM
$LogFileDate = $Month + $Day
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
$VcsLogPath = "c:\Program Files (x86)\Brother\Omnijoin\vcs\logs"
$SipLogPath = "c:\Program Files (x86)\Brother\Omnijoin\vcs\SipLogs"

$VcsLog = $VcsLogPath +"\vcs.log"
$VcsHttpLog = $VcsLogPath +"\vcs_http_$LogFileDate.log"
$VcsAccessLog = $VcsLogPath +"\vcs_access_$LogFileDate.log"
$VcsTracerouteLog = $VcsLogPath +"\vcs_traceroute.log"
$VcsXmlIntercallLog = $VcsLogPath +"\vcs_xml_intercall.log"
$Convert2PdfLog = $VcsLogPath +"\Convert2Pdf.log"
$VcsProxyLog = $SipLogPath +"\vcs.proxy.log"
$VcsSipclientLog = $SipLogPath +"\vcs_sipclient.log"

# Call TestPath function to Test to see if log file exists and copy file to desktop folder
TestPath $VcsLog
TestPath $VcsHttpLog
TestPath $VcsAccessLog
TestPath $VcsTracerouteLog
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
$VcsXmlIntercallLogTest = $FolderPath +"\vcs_xml_intercall.log"
VerifyFileCopy $VcsXmlIntercallLogTest
$Convert2PdfLogTest = $FolderPath +"\Convert2Pdf.log"
VerifyFileCopy $Convert2PdfLogTest
$VcsProxyLogTest = $FolderPath +"\vcs.proxy.log"
VerifyFileCopy $VcsProxyLogTest
$VcsSipclientLogTest = $FolderPath +"\vcs_sipclient.log"
VerifyFileCopy $VcsSipclientLogTest






#Write-Host "You can compare the current date against the date part only of each file LastWriteTime short date:"
#Get-ChildItem $FilePath | Where-Object {$_.LastWriteTime.ToShortDateString() -eq (Get-Date).ToShortDateString()}



# Create the zip file 
# Create alias for 7z
if (-not (test-path "$env:C:\Program Files\7-Zip\7z.exe")) {throw "$env:Program Files (x86)\7-Zip\7z.exe needed"} 
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"

# Zip the folder
sz a -t7z "$FolderPath" "$FolderPath"









