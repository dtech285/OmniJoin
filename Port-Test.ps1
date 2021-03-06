<#  
       
.NOTES
 Version:        1.0
 Author:         David Boyett
 Email:          David.Boyett@Brother.com
 Creation Date:  10/18/2016
 Purpose/Change: Initial script development

.SYNOPSIS
Perform port connectivity tests.

.DESCRIPTION
The description is usually a longer, more detailed explanation of what the script or function does. Take as many lines as you need

.PARAMETER <Parameter_Name>
None

.INPUTS
None

.OUTPUTS
HTML Report example: Log file stored in C:\Windows\Temp\<name>.log>
  
.EXAMPLE
N/A
#>

#-----------[Initialisations]--------------------------------------------------------




#-----------[Declarations]----------------------------------------------------------

#Script Version
$ScriptVersion = "1.0"


#-----------[Functions]------------------------------------------------------------


#==========================================================================================
#====================     Show-Menu                                 =======================
#==========================================================================================
# Display menu 
function Show-Menu
{
     param (
           [string]$Title = 'Port Testing'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' VCS TCP Tests."
     Write-Host "2: Press '2' SIPS TCP Tests."
     Write-Host "3: Press '3' RTP Tests."
     Write-Host "4: Press '4' Remote Req. Tests."
     Write-Host "5: Press '5' Run All Tests."
     Write-Host "6: Press '6' Enter New Host."
     Write-Host "Q: Press 'Q' to quit."
}

#==========================================================================================
#====================                    Vcs-Tests                  =======================
#==========================================================================================
Function Vcs-Tests ($HostName, $VcsPortNumbers)
# Test ports 22, 23, 80, 443, 1270, 37000
# step through array of port numbers and call the Test-Ports function for those port numbers

# NEED TO ADD PORT TO A FILE OR HTTP REPORT
{
    Write-Host "Running VCS Port tests for "$HostName
    foreach ($PortNumber in $VcsPortNumbers)
    {
        Test-Port $HostName $PortNumber
    }
    

}

#==========================================================================================
#====================                    Sips-Tests                 =======================
#==========================================================================================
Function Sips-Tests($HostName, $SipsPortNumbers)
{
    Write-Host "Running Sips Port Tests for" $HostName
    foreach ($PortNumber in $SipsPortNumbers)
    {
        Test-Port $HostName $PortNumber
    }


}

#==========================================================================================
#====================                    Rtp-Tests                  =======================
#==========================================================================================
Function Rtp-Tests($HostName)
{
    Write-Host "Running Rtp-Tests"
    $RdpPortNumber = 10050
    Test-Port $HostName $RdpPortNumber

}


#==========================================================================================
#====================                    RemoteReq-Tests            =======================
#==========================================================================================
Function RemoteReq-Tests
{
    Write-Host "RemoteReq-Tests"

}

#==========================================================================================
#====================                    RDP-Tests            =======================
#==========================================================================================
Function RDP-Tests
{
    Write-Host "Running RDP-Tests"`n
    $RdpPortNumber = 10050
    Test-Port $HostName $RdpPortNumber

}

#==========================================================================================
#====================                    RunAllTests                =======================
#==========================================================================================
Function RunAllTests($HostName)
{
    Write-Host "Running all tests"

}

#==========================================================================================
#====================                    Get HostName               =======================
#==========================================================================================
# Get HostName from user
Function Get-HostName
{
    
    $HostName = Read-Host "Enter IP Address or FQDN of destination server"
    DetermineMenuSelection

}

#==========================================================================================
#====================             DetermineMenuSelection            =======================
#==========================================================================================
# Display menu for user input
Function DetermineMenuSelection
{
    do
    {
        Show-Menu
        $input = Read-Host "Please make a selection"
        switch ($input)
        {
           '1' 
               {
                    cls
                    Vcs-Tests $HostName $VcsPortNumbers
               }
           '2' 
               {
                   cls
                   Sips-Tests $HostName $SipsPortNumbers
               }
           '3' 
                {
                    cls
                    Rtp-Tests 
                }
           '4' 
                {
                    cls
                    RDP-Tests $HostName 
                     
                }
           '5'
                {
                    cls
                    RunAllTests $HostName
                }
            '6'
                {
                    cls
                    Get-HostName
                }
            'q' 
                {
                    return
                }
        }
        pause
     
    }
    until ($input -eq 'q')


}

#==========================================================================================
#====================                    Test-Ports                 =======================
#==========================================================================================
function Test-Port($HostName, $PortNumber)
{
    # This works no matter in which form we get $host - hostname or ip address
    try {
        $ip = [System.Net.Dns]::GetHostAddresses($HostName) | 
            select-object IPAddressToString -expandproperty  IPAddressToString
        if($ip.GetType().Name -eq "Object[]")
        {
            #If we have several ip's for that address, let's take first one
            $ip = $ip[0]
        }
    } catch {
        Write-Host "Possibly $HostName is wrong hostname or IP"
        return
    }
    $t = New-Object Net.Sockets.TcpClient
    # We use Try\Catch to remove exception info from console if we can't connect
    try
    {
        $t.Connect($ip,$PortNumber)
    } catch {}

    if($t.Connected)
    {
        $t.Close()
        #$msg = "Port $PortNumber is operational"
        Write-Host "Port $PortNumber on $ip is.............." -NoNewLine; Write-Host "OPEN." -ForegroundColor Green
    }
    else
    {
        $msg = "Port $PortNumber on $ip is...............closed, " 
        #$msg += "You may need to contact your IT team to open it. "
        Write-Host "Port $PortNumber on $ip is.............." -NoNewLine; Write-Host "CLOSED." -ForegroundColor Red                                 
    }
    
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------


#Need to get target address from user.
$VcsPortNumbers = 22, 23, 80, 443, 1270, 37000
$SipsPortNumbers = 5061, 5060, 5076, 5075

#Get HostName from user
Get-HostName

#$HostName = Read-Host "Enter IP Address or FQDN of destination server"
# 
DetermineMenuselection



