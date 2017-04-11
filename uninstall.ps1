## uninstall software

#get list of installed software

$appName = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize | Where-Object {$_.Name -match "Dropbox"}
Write-Host "AppName is "$appName
#Get-WmiObject -Class Win32_Product | Select-Object -Property Name

Write-Host "======================================"
#Get-WmiObject -Class win32_product

#Filter
Get-WmiObject -Class win32_product -Filter "Name like '%Dropbox%'"