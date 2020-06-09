$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential




Get-MSOLUser -UserPrincipalName l.graf@baldeggersortec.ch | Select ImmutableID

Set-MSOLUser -UserPrincipalName l.graf@baldeggersortec.ch -ImmutableID V65l+PPXp0iQgUCztVY6ng==