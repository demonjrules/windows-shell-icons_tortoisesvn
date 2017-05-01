# windows-shell-icons_tortoisesvn

Example: You install TortoiseSVN and you can see in windows explorer that files in a repository are modified by looking at the icon.
g
    
![alt text](http://i.imgur.com/MqdtgX7l.png)

You then install something like Dropbox or Google Drive and the TortoiseSVN icons are now missing. Windows has a limit of 15 shell icons it can use for icon overlays. The first 15 keys in the registry are the ones that are shown. Instead of manually editing the registry, I made this Powershell script to modify the registry to make TortoiseSVN folder overlay icons the priority in Windows.

This script removes leading spaces from all the registry keys in HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers and then prefixes all the TortioseSVN entries with 01, 02, 03 etc. so that they are first. The script also removes the permission from NT AUTHORITY\SYSTEM so that future installed applications cannot modify the registry.

Run the script by opening up a command window, changing to the folder with the script, running powershell and then running the script.

1. Open command prompt 
2. cd c:\users\Jack\Downloads\windows-shell-icons_tortoisesvn
3. Powershell
4. .\windowsIconsTortoise.ps1

After the script is done running, restart windows explorer (explorer.exe) and you're finished. 
