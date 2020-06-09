$UserCredential = Get-Credential
Import-Module MSOnline
Connect-MsolService -Credential $UserCredential


#Enabled (Means the user has been enabled but they have not yet completed MFA registration)
Get-MsolUser -All | where {$_.StrongAuthenticationRequirements.state -eq ‘Enabled’ } | Select-Object -Property UserPrincipalName,whencreated,islicensed,BlockCredential | export-csv enabled.csv -noTypeInformation

#Enforced (The user has completed MFA registration, so their account is not protected by MFA)
Get-MsolUser -All | where {$_.StrongAuthenticationRequirements.state -eq ‘Enforced’ } | Select-Object -Property UserPrincipalName,whencreated,islicensed,BlockCredential | export-csv enforced.csv -noTypeInformation

#Not Yet Enabled (These users have not yet been enabled for MFA)
Get-MsolUser -All | where {$_.StrongAuthenticationMethods.Count -eq 0 -and $_.UserType -ne ‘Guest’} | Select-Object -Property UserPrincipalName | export-csv non-enabled.csv -noTypeInformation