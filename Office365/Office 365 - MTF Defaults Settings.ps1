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



[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title = 'Empfänger von Admin-Mails'
$msg   = 'E-Mailadresse des Empfänger von Admin-Mails'
$RecipientAdminMails = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)



Enable-OrganizationCustomization



####################################################################
#
#   Default-SPAM-Richtlinie konfigurieren
#
####################################################################

Set-HostedContentFilterPolicy -Identity Default -HighConfidenceSpamAction Quarantine -SpamAction Quarantine -BulkSpamAction Quarantine -PhishSpamAction Quarantine -EnableEndUserSpamNotifications:$True -EndUserSpamNotificationLanguage "German" -EndUserSpamNotificationFrequency "1"


####################################################################
#
#   Default-Malware-Richtlinie konfigurieren
#
####################################################################

Set-MalwareFilterPolicy -Identity Default -InternalSenderAdminAddress $RecipientAdminMails -ExternalSenderAdminAddress $RecipientAdminMails -Action DeleteAttachmentAndUseDefaultAlertText -EnableInternalSenderNotifications:$True -EnableInternalSenderAdminNotifications:$True -EnableExternalSenderAdminNotifications:$True -EnableFileFilter:$True


####################################################################
#
#   Neue Aufbewahrungs-Richtlinie erstellen
#
####################################################################

$RetentionCompliancePolicyName = "Default Retention-Policy"

New-RetentionCompliancePolicy -Name $RetentionCompliancePolicyName
New-RetentionComplianceRule -Name $RetentionCompliancePolicyName -Policy $RetentionCompliancePolicyName -RetentionDurationDisplayHint Days -RetentionDuration 3650 -RetentionComplianceAction KeepAndDelete -ExpirationDateOption ModificationAgeInDays


####################################################################
#
#   Konfigurieren Ausgehende Spamnachrichten-Richtlinie
#
####################################################################

Set-HostedOutboundSpamFilterPolicy -Identity Default -BccSuspiciousOutboundAdditionalRecipients $RecipientAdminMails -NotifyOutboundSpamRecipients $RecipientAdminMails -BccSuspiciousOutboundMail:$True -NotifyOutboundSpam:$True


####################################################################
#
#   Aufforderung um Passwort-Richtlinie anzupassen
#
####################################################################

[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
$title = 'Passwortrichtlinie'
$msg   = 'Passowortrichtlinie im Admin-Center anpassen: https://portal.office.com/adminportal/home#/settings/security'
[Microsoft.VisualBasic.Interaction]::MsgBox($msg, "OKOnly,SystemModal,Information", $title)


####################################################################
#
#   Clutter deaktivieren
#
####################################################################

Get-mailbox -ResultSize Unlimited | Set-Clutter -Enable $false


####################################################################
#
#   Enable global audit logging
#
####################################################################

Get-mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox" -or RecipientTypeDetails -eq "SharedMailbox" -or RecipientTypeDetails -eq "RoomMailbox" -or RecipientTypeDetails -eq "DiscoveryMailbox"} | Set-mailbox -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin Update, MoveToDeletedItems, SoftDelete, HardDelete, SendAs, SendOnBehalf, Create, UpdateFolderPermission -AuditDelegate Update, SoftDelete, HardDelete, SendAs, Create, UpdateFolderPermissions, MoveToDeletedItems, SendOnBehalf -AuditOwner UpdateFolderPermission, MailboxLogin, Create, SoftDelete, HardDelete, Update, MoveToDeletedItems 


####################################################################
#
#   Aufzeichnung von Benutzer- und Administratoraktivitäten starten
#
####################################################################

Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled:$True


####################################################################
#
#   Enable modern authentication
#
####################################################################

# Exchange Online
Set-OrganizationConfig -OAuth2ClientProfileEnabled:$true
# Skype Online
Set-CsOAuthConfiguration -ClientAdalAuthOverride Allowed
