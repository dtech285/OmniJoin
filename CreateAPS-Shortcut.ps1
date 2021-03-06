<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Creation Date:  9/30/16
 Purpose/Change: Initial script development

.SYNOPSIS
Create a shortcut to the VCS log folder and save on the desktop

.DESCRIPTION
Create a shortcut to the VCS log folder and save on the desktop

.PARAMETER <Parameter_Name>
None

.INPUTS
None

.OUTPUTS
Desktop shortcut
  
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

# Variable to store shortcut location
$AppLocation = "C:\Program Files\Brother\Omnijoin\APS"

# Create new object and assign to $WshShell variable
$WshShell = New-Object -ComObject WScript.Shell

# Create the shortcut and store in variable
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\APS.lnk")

# assign the location to the path
$Shortcut.TargetPath = $AppLocation

# Save the shortcut
$Shortcut.Save()
