﻿$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session



####################################################################
#
#   Clutter deaktivieren
#
####################################################################

Get-Mailbox -ResultSize Unlimited | Set-Clutter -Enable:$False


####################################################################
#
#   Enable global audit logging
#
####################################################################

Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox" -or RecipientTypeDetails -eq "SharedMailbox" -or RecipientTypeDetails -eq "RoomMailbox" -or RecipientTypeDetails -eq "DiscoveryMailbox"} | Set-Mailbox -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin Update, MoveToDeletedItems, SoftDelete, HardDelete, SendAs, SendOnBehalf, Create, UpdateFolderPermission -AuditDelegate Update, SoftDelete, HardDelete, SendAs, Create, UpdateFolderPermissions, MoveToDeletedItems, SendOnBehalf -AuditOwner UpdateFolderPermission, MailboxLogin, Create, SoftDelete, HardDelete, Update, MoveToDeletedItems 






#Double-Check It!
#Get-Mailbox -ResultSize Unlimited | Select Name, AuditEnabled, AuditLogAgeLimit | Out-Gridview