$UserCredential = Get-Credential
Import-Module azuread
Connect-AzureAD -Credential $UserCredential

