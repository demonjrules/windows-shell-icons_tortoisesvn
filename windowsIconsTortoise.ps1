. Use-RunAs.ps1
use-runas

$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers';

$i = 0
Get-ChildItem $path | ForEach-Object {
	## finds tortoise entries and prioritize them over others...
	if($_.PSChildName -like "  Tortoise*"){
		$i++
		$name = $_.PSChildName
		$newName = "0${i}_" + $name.trim()
		write-host $newName
		rename-item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\$name" -newname $newName
	}
	## Trims entries with spaces...
	elseif($_.PSChildName -like " *" ){
		$name = $_.PSChildName
		$newName = $name.trim()
		write-host $newName
		rename-item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\$name" -newname $newName
	}
}

if ((get-acl $path | Select-Object -ExpandProperty Owner) -eq "NT AUTHORITY\SYSTEM"){
	write-host "Setting owner and permissions..."
	$account = New-Object -TypeName System.Security.Principal.NTAccount -ArgumentList 'Administrators';
	$acl = Get-Acl -Path $path;
	$acl.SetOwner($account);
	$acl.SetGroup($account);

	$permission = "NT AUTHORITY\SYSTEM","FullControl","ObjectInherit,ContainerInherit","None","deny"
	$rule = New-Object System.Security.AccessControl.RegistryAccessRule $permission
	
	$acl.SetAccessRule($rule)

	Set-Acl -Path $path -AclObject $acl;
}

Write-Host '-------------------------'
Write-Host 'Finished'
Write-Host -NoNewLine 'Press any key to continue...'
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
