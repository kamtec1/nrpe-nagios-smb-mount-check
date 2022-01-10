# TEST SMB NAGIOS VIA MOUNT


Set-Variable OK 0 -option Constant
Set-Variable WARNING 1 -option Constant
Set-Variable CRITICAL 2 -option Constant
Set-Variable UNKNOWN 3 -option Constant

# Mount smb to windows

$mountnagios=New-SmbMapping -RemotePath '\\10.10.10.10\docs' -LocalPath 'N:' -Username "workgroup\USERNAME" -Password "PASS" | select status -ExpandProperty status


  if ($mountnagios -eq 'OK')
	{
		$resultstring='OK MOUNT SUCCESSFUL' 
		$exit_code = $OK
	}
	else
	{
   $resultstring='MOUNT CRITICAL' + $mountnagios + ''
   $exit_code = $CRITICAL
	}

#unmount before next check to avoid FP

$unmountnagios=Remove-SmbMapping -LocalPath "N:" -Force

Write-Host $resultstring
exit $exit_code
