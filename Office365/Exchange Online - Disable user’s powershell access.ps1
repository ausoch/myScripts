#Disable user’s powershell access in Exchange Online, ex:


get-user | set-user -RemotePowerShellEnabled $false


#Did you know if you run this, it won’t disable powershell on the admin account you are running it on? Its smart enough not to lock yourself out!