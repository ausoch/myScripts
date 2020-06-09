#   Erstellen einer neuen ManagementRolle "MyBaseOptions-NoForwarding" basierend auf "MyBaseOptions"                                #
#   damit die Option "Weiterleitung" ind den E-Mail Optionen nicht vorhanden ist                                                    #
#                                                                                                                                   #
#   Details hier: https://exchangepedia.com/2015/03/disable-automatic-forwarding-of-email-in-office-365-and-exchange-server.html    #
#                                                                                                                                   #
#####################################################################################################################################


# Erstellen der neuen ManagementRolle
New-ManagementRole MyBaseOptions-NoForwarding -Parent MyBaseOptions
Set-ManagementRoleEntry MyBaseOptions-NoForwarding\Set-Mailbox -RemoveParameter -Parameters DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress



# Filtern nach User die das Weiterleiten aktiviert haben
Get-Mailbox -Filter {Name -notlike "DiscoverySearchMailbox*" -and ForwardingSmtpAddress -ne $null} | ft name,*forward* -auto

# Deaktivieren der Weiterleitung
Get-Mailbox -Filter {Name -notlike "DiscoverySearchMailbox*" -and ForwardingSmtpAddress -ne $null} | Set-Mailbox -ForwardingSmtpAddress $null