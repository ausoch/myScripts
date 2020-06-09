####################################################################
#
#   Powershellscript um MTF-Default-Settings von Office 365/Exchange Online
#   zu setzten. 
#
#
#   !!! WICHTIG: Script nicht auf Exchange-Server ausführen !!!
#   Folgened muss zuerst auf dem PC installiert werden:
#   -Exchange Online PowerShell   -->   
#   -Skype for Business Powershell   -->   https://technet.microsoft.com/en-us/library/dn362839(v=ocs.15).aspx
#
#   !!! WICHTIG: Script nicht auf Exchange-Server ausführen !!!
#
####################################################################




$UserCredential = Get-Credential
$Session1 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
$Session2 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
$Session3 = New-CsOnlineSession -Credential $UserCredential
Import-PSSession $Session1
Import-PSSession $Session2
Import-PSSession $Session3
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential





####################################################################
#
#   Enable modern authentication
#
####################################################################

# Exchange Online
Get-OrganizationConfig | fl OAuth2ClientProfileEnabled

Set-OrganizationConfig -OAuth2ClientProfileEnabled:$true

# Skype Online
Get-CsOAuthConfiguration | fl ClientAdalAuthOverride

Set-CsOAuthConfiguration -ClientAdalAuthOverride Allowed
