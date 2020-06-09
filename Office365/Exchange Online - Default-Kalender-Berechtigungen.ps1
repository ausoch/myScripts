#                                                                                            #
#   Script zum anpassen der Default-Kalender-Berechtigungen                                  #
#                                                                                            #
##############################################################################################

$UserCredential = Get-Credential 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session 
foreach($user in Get-Mailbox -RecipientTypeDetails UserMailbox) {
$cal = $user.alias+":\Kalender"  #für Englische Postf$cher ist es "Calendar"
Set-MailboxFolderPermission -Identity $cal -User Default -AccessRights Reviewer
}
