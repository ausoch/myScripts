#                                                                                            #
#   Sript zum entfernen von SMTP-Mail-Adressen (zB domain.local) von Mailboxen               #
#                                                                                            #
#   Wichtig! Mail-Domäne die entfernt werden soll in Zeile 27 anpassen                       #
#                                                                                            #
##############################################################################################


# Get all mailboxes
$mailboxes = Get-Mailbox;

# oder
# Get all shared-mailboxes
#$mailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox;



# Loop through each mailbox
foreach ($mailbox in $mailboxes) {
 
    $emailaddresses = $mailbox.emailaddresses;
 
    #Loop through each SMTP address found on each mailbox
    for ($i=0; $i -lt $emailaddresses.count; $i++) {
        
        # Change the domain name below to what you want to remove
        if ($emailaddresses[$i].smtpaddress -like "*intranet.hansleutenegger.ch") {
 
            # Remove the unwanted email address
            $badaddress = $emailaddresses[$i];
            $emailaddresses = $emailaddresses - $badaddress;
            $mailbox | set-mailbox -emailaddresses $emailaddresses;
 
        }
 
    }
 
}
 