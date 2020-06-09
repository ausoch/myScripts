# To establish a remote PowerShell session with Skype for Business Online, you first need to install
# the Skype for Business Online module for Windows PowerShell, which you can get here: 
# http://go.microsoft.com/fwlink/p/?LinkId=391911.
# After you install the module, you can establish a remote session with the following cmdlets:

Import-Module LyncOnlineConnector

$cred = Get-Credential

$CSSession = New-CsOnlineSession -Credential $cred

Import-PSSession $CSSession -AllowClobber
