<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Creation Date:  4/5/2017
 Purpose/Change: Initial script development

.SYNOPSIS
Make a copy of the vcs log, search for and output exceptions.

.DESCRIPTION
Copies the VCS log and places it on the desktop. Parse the log for exception entries for the current date.

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
# Store contents of file in variable
#$content = Get-Content C:\Users\dboyett\vcs.log


# Get current user
# <enter code here>

#========================================================================================
# FILE VALIDATION AND COPY
#========================================================================================
# create a copy of the VCS log and place it on the desktop

$FileDestination = "c:\Users\dboyett\Desktop"
$ChkFile = "C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs.log"

$FileExists = Test-Path $ChkFile

# Check to see if file exists in logs directory
If ($FileExists -eq $True) 
{
    
    #Copy the file and place on the desktop
    $ChkFile ="C:\Program Files (x86)\Brother\Omnijoin\vcs\logs\vcs.log"
    #Write-Host $ChkFile
    Copy-Item $ChkFile $FileDestination   
}
Else
{
    Write-Host "ERROR: FILE DOES NOT EXIST IN LOGS DIRECTORY"
}

# Check to see if copy was successful and open the file
$CopyChkFile = "C:\Users\dboyett\Desktop\vcs.log"
$CopyFileExists = Test-Path $CopyChkFile
If ($CopyFileExists -eq $True)
{
    $FileToOpen = "c:\Users\dboyett\Desktop\vcs.log"
    #Invoke-Item $FileToOpen
}
Else
{
    Write-Host "ERROR: FILE DOES NOT EXIST ON DESKTOP"
}

#========================================================================================
# FILE PARSING AND OUTPUT
#========================================================================================
$date = Get-Date -Format d

# Get all entries in the log with the current date
$matches = Select-String -Path C:\Users\dboyett\desktop\vcs.log -Pattern "$date" -AllMatches | Foreach {$_.Line} 

Write-Host "`n"
# Print the exception from the current date
foreach ($match in $matches | Select-String 'Exception')
{
    Write-Host $match "`n"

}



