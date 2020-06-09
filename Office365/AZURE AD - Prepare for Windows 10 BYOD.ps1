#                                                                                                                            #
#   AZURE AD - Prepare for Windows 10 BYOD                                                                                   #
#   Vorbereiten des OnPremis AD                                                                                              #
#                                                                                                                            #
#   http://c7solutions.com/2015/07/configuring-writeback-permissions-in-active-directory-for-azure-active-directory-sync     #
#                                                                                                                            #
##############################################################################################################################


$accountName = "domain\aad_account"   #[this is the account that will be used by Azure AD Connect Sync to manage objects in the directory, this is an account usually in the form of AAD_number].
$azureAdCreds = Get-Credential   #[Azure Active Directory administrator account]



Initialize-ADSyncDomainJoinedComputerSync -AdConnectorAccount $accountName -AzureADCredentials $azureAdCreds
Initialize-ADSyncNGCKeysWriteBack -AdConnectorAccount $accountName