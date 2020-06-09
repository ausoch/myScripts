$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session



# Anzeigen der Kalender-Berechtigungen
get-MailboxFolderPermission -Identity _Sitzungszimmer:\kalender

# Setzte der Kalender-Berechtigungen auf LimitedDetails für den User Default der Mailbox _Sitzungszimmer
Set-MailboxFolderPermission -AccessRights LimitedDetails -Identity _Sitzungszimmer:\kalender -User default

# Setzte der Kalender-Berechtigungen auf AvailabilityOnly für den User Default der Mailbox _Sitzungszimmer
Set-MailboxFolderPermission -AccessRights AvailabilityOnly -Identity _Sitzungszimmer:\kalender -User default