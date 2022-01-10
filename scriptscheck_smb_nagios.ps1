#nrpe-nagios-smb-mount-check v 1.0
#Last update: 10.01.2022
#Written by Sergey Babkevych (kamtec1) SecurityInet 
#SecurityInet Web site for updates regarding new release
#https://www.securityinet.com
#Github link for updates:
#https://github.com/kamtec1/nrpe-nagios-smb-mount-check/
#nrpe-nagios-smb-mount-check is licensed under the GNU General Public License v3.0
#If you hgave questions you may send me a massage : kamtec1@gmail.com or sergey@securityinet.com



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
