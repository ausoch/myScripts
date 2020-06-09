[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title = 'Vorname'
$msg   = 'Wie lautet der Vorname:'
$FirstName = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)



[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title = 'Nachname'
$msg   = 'Wie lautet der Nachname:'
$LastName = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)



[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title = 'Benuztername'
$msg   = 'Wie lautet der ActiveDirectory-Benutzername (vorname.nachname):'
$Benutzername = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)


#$FirstName = "Marc"
#$LastName = "Gehri"
#$Benutzername = "marc.gehri"


##########################################################################################
# Erstellen des AD-Users und Office 365 Mailbox
##########################################################################################

$DisplayName = $LastName+" "+$FirstName
$UserPrincipalName = $Benutzername+"@mtf-be.ch"
$OnPremisesOrganizationalUnit = "mtf.internal/_Bern/Users"
$PrimarySmtpAddress = $Benutzername+"@mtf-be.ch"
$RemoteRoutingAddress = $Benutzername+"@mtfbern.mail.onmicrosoft.com"
$UserCredentials = Get-Credential –credential $Benutzername

New-RemoteMailbox -Name $DisplayName -FirstName $FirstName -LastName $LastName -DisplayName $DisplayName -Password $UserCredentials.Password -PrimarySmtpAddress $PrimarySmtpAddress -UserPrincipalName $UserPrincipalName -OnPremisesOrganizationalUnit $OnPremisesOrganizationalUnit



##########################################################################################
# 30 Minuten warten bis User nach Office 365 synchronisiert wurde
##########################################################################################

Start-Sleep -s 1800



##########################################################################################
# Zuweisen von Office 365 Lizenzen
##########################################################################################

#This first command will import the Azure Active Directory module into your PowerShell session.
Import-Module MSOnline

#Capture administrative credential for future connections.
$O365credential = Import-Clixml "C:\tools\O365AdminCredentials.xml"

#Establishes Online Services connection to Azure Active Directory  
Connect-MsolService -Credential $O365credential

Set-MsolUser -UserPrincipalName $UserPrincipalName -UsageLocation CH
Set-MsolUserLicense -UserPrincipalName $UserPrincipalName -AddLicenses "mtfbern:ENTERPRISEPACK"
Set-MsolUserLicense -UserPrincipalName $UserPrincipalName -AddLicenses "mtfbern:POWER_BI_STANDARD"
Set-MsolUserLicense -UserPrincipalName $UserPrincipalName -AddLicenses "mtfbern:EMS"



##########################################################################################
# Clutter deaktivieren
# Add Reviewer-Berechtigung für Kalender
##########################################################################################

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $O365credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -Prefix O365

Get-O365mailbox -Identity $UserPrincipalName | Set-O365Clutter -Enable $false

Set-O365MailboxFolderPermission -Identity $UserPrincipalName":\Kalender" -User Default -AccessRights Reviewer # Kalender auf Deutsch
Set-O365MailboxFolderPermission -Identity $UserPrincipalName":\Calendar" -User Default -AccessRights Reviewer # Kalender auf Englisch

Remove-PSSession -Name $Session

