<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Creation Date:  9/30/16
 Purpose/Change: Initial script development

.SYNOPSIS
Make a copy of the vcs log

.DESCRIPTION
Copies the VCS log and places it on the desktop and opens it

.PARAMETER <Parameter_Name>
<Brief description of parameter input required. Repeat this attribute if required>

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
$ScriptVersion = "1.0"


#-----------[Functions]------------------------------------------------------------

<#
Function <FunctionName>
{
<#
    .DESCRIPTION
        < function descrtion >
 
    .PARAMETER  < parameter name >
        < parameter descrtiption >
   
    .EXAMPLE
        < example >
        
  
}

#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------


#Script Execution goes here
#Write-Host `n"Script Version:" $ScriptVersion`n
#Write-Host "$ScriptVersion is version"`n

# create a copy of the VCS log and place it on the desktop

$FileDestination = "c:\Users\dboyett\Desktop"
$ChkFile = "C:\Program Files\Brother\Omnijoin\WPS\trace.log"

$FileExists = Test-Path $ChkFile

# Check to see if file exists in logs directory
If ($FileExists -eq $True) 
{
    Write-Host `n"File Exists in logs directory"`n
    
    #Copy the file and place on the desktop
    $ChkFile ="C:\Program Files\Brother\Omnijoin\WPS\logs\trace.log"
    Write-Host $ChkFile
    Copy-Item $ChkFile $FileDestination

}
Else
{
    Write-Host "ERROR: FILE DOES NOT EXIST IN LOGS DIRECTORY"

}

# Check to see if copy was successful and open the file
$CopyChkFile = "C:\Users\dboyett\Desktop\trace.log"
$CopyFileExists = Test-Path $CopyChkFile
If ($CopyFileExists -eq $True)
{
    $FileToOpen = "c:\Users\dboyett\Desktop\trace.log"
    Invoke-Item $FileToOpen
}
Else
{
    Write-Host "ERROR: FILE DOES NOT EXIST ON DESKTOP"
}