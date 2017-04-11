


# Open v7 VCS and APS in IE
$ie = New-Object -ComObject InternetExplorer.Application
$ie.Navigate2("https://v7.omnijoin.com/_admin/FieldServerMonitor.aspx?Field=Public&Type=VCS")
$ie.Navigate2("https://v7.omnijoin.com/_admin/FieldServerMonitor.aspx?Field=Public&Type=APS", 0x1000)
$ie.Visible = $true

$ie = New-Object -ComObject InternetExplorer.Application
$ie.Navigate2("https://10.70.142.115/ontime/default.aspx")
$ie.Navigate2("https://login.salesforce.com/", 0x1000)
$ie.Visible = $true

