<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 File:           CreateTestFiles.ps1
 Creation Date:  10/06/2016
 Purpose/Change: Initial script development

.SYNOPSIS
The synopsis goes here. This can be one line, or many.

.DESCRIPTION
The description is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need

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


#>
Function ChkFileExists([string]$ChkFile)
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
        # Report if file exists
        Write-Host "File exists: "$ChkFile
    }
    Else
    {
        # create the file
        New-Item $ChkFile
    }
}
    

#-----------------------------------------------------------[Execution]------------------------------------------------------------


#Script Execution goes here
#Write-Host `n"Script Version:" $ScriptVersion`n
#Write-Host "$ScriptVersion is version"`n

#Get Date
$Day = Get-Date -Format dd
$Month = Get-Date -Format MM
$LogFileDate = $Month + $Day
$V7LogFileDate = Get-Date -f 'yyyyMMdd'

# Create v6 string
$CreateAccessFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs_access_$LogFileDate.log"
$CreateHttpFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs_http_$LogFileDate.log"


# Create v7 string
$CreateV7AccessFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs_access_$V7LogFileDate.log"
$CreatV7HttpFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs_http_$V7LogFileDate.log"
$CreateXMLFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs_xml_intercall_$V7LogFileDate.log"


# Call ChkFileExists Function to create files
ChkFileExists $CreateAccessFile
ChkFileExists $CreateHttpFile
ChkFileExists $CreateV7AccessFile
ChkFileExists $CreatV7HttpFile
ChkFileExists $CreateXMLFile



