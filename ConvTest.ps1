# run the conversion executable to convert vcs.sdb to a readable txt file
& "c:\Program Files (x86)\Brother\OmniJoin\vcs\sdb2txt.exe" .\Logs\VCS.sdb > output.txt

clear

# Move file to desktop so we're not working in the vcs directory
Move-Item c:\"Program Files (x86)"\Brother\OmniJoin\vcs\output.txt c:\users\$env:USERNAME\Desktop


$FileToOpen = "c:\users\$env:USERNAME\Desktop\output.txt"
# $FileToOpen = "C:\Program Files (x86)\Brother\OmniJoin\vcs\output.txt"
Invoke-Item $FileToOpen