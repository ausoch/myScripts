#Disable POP/IMAP for future mailboxes and current mailboxes
#Examples:

#All Future Mailboxes
Get-CASMailboxPlan | set-CASMailboxPlan -ImapEnabled $false -PopEnabled $false

#All Existing Mailboxes:
get-casmailbox | set-casmailbox -imapenabled $false -PopEnabled $false