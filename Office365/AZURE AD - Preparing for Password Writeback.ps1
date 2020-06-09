#                                                                                                                            #
#   AZURE AD - Preparing for Password Writeback                                                                              #
#   Vorbereiten des OnPremis AD                                                                                              #
#                                                                                                                            #
#   http://c7solutions.com/2015/07/configuring-writeback-permissions-in-active-directory-for-azure-active-directory-sync     #
#                                                                                                                            #
##############################################################################################################################


$accountName = "domain\aad_account"   #[this is the account that will be used by Azure AD Connect Sync to manage objects in the directory, this is an account usually in the form of AAD_number].
$passwordOU = "DC=contoso,DC=com"   #[you can scope this down to a specific OU]



$cmd = "dsacls.exe '$passwordOU' /I:S /G '`"$accountName`":CA;`"Reset Password`";user'"
Invoke-Expression $cmd | Out-Null

$cmd = "dsacls.exe '$passwordOU' /I:S /G '`"$accountName`":CA;`"Change Password`";user'"
Invoke-Expression $cmd | Out-Null

$cmd = "dsacls.exe '$passwordOU' /I:S /G '`"$accountName`":WP;lockoutTime;user'"
Invoke-Expression $cmd | Out-Null

$cmd = "dsacls.exe '$passwordOU' /I:S /G '`"$accountName`":WP;pwdLastSet;user'"
Invoke-Expression $cmd | Out-Null