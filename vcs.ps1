<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Email:          David.Boyett@Brother.com
 Creation Date:  4/10/2017
 Purpose/Change: Initial script development

.SYNOPSIS
Convert vcs.sdb to a readable text file

.DESCRIPTION
Convert vcs.sdb to a readable text file. Move the created file to the desktop and open it.

.PARAMETER <Parameter_Name>
None

.INPUTS
None

.OUTPUTS
Log file stored in c:\users\$env:USERNAME\Desktop\output.txt
  
.EXAMPLE
None
#>

#-----------[Initialisations]--------------------------------------------------------

# None


#-----------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"


#-----------[Functions]------------------------------------------------------------


#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------


clear
Set-Location -Path c:\"Program Files (x86)"\Brother\OmniJoin\vcs

# run the conversion executable to convert vcs.sdb to a readable txt file
& "c:\Program Files (x86)\Brother\OmniJoin\vcs\sdb2txt.exe" .\Logs\VCS.sdb > output.txt

clear

# Move file to desktop so we're not working in the vcs directory
Move-Item c:\"Program Files (x86)"\Brother\OmniJoin\vcs\output.txt c:\users\$env:USERNAME\Desktop


$FileToOpen = "c:\users\$env:USERNAME\Desktop\output.txt"
# $FileToOpen = "C:\Program Files (x86)\Brother\OmniJoin\vcs\output.txt"
Invoke-Item $FileToOpen