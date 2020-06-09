$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


# Zeige Postfachregeln mit Details 
Get-InboxRule -mailbox meteobriefing | fl

# Anpassen der Regel für Meteobriefing-Mailbox 
Get-InboxRule -mailbox meteobriefing -Identity "Mail from ais.zrh@skyguide.ch oder dabs.zmsvp01@skyguide.ch weiterleiten" |Set-InboxRule -FromAddressContainsWords {dabs.zmsvp01@skyguide.ch, ais.zrh@skyguide.ch}
