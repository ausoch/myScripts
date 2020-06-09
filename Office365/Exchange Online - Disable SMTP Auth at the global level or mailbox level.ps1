#Disable SMTP Auth at the global level or mailbox level. This prevents users from using this as a brute force vector.

#Global Level
Set-TransportConfig -SmtpClientAuthenticationDisabled $true

#Mailbox Level
Get-casmailbox -resultsize unlimited | Set-CASMailbox -SmtpClientAuthenticationDisabled $true