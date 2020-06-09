#                                                                                                                            #
#   AZURE AD - Preparing for Device Writeback                                                                                #
#   Vorbereiten des OnPremis AD                                                                                              #
#                                                                                                                            #
#   http://c7solutions.com/2015/07/configuring-writeback-permissions-in-active-directory-for-azure-active-directory-sync     #
#                                                                                                                            #
##############################################################################################################################


$accountName = "domain\aad_account"   #[this is the account that will be used by Azure AD Connect Sync to manage objects in the directory, this is an account in the form of AAD_number].
$domain = "contoso.com"    #[domain where devices will be created].



Initialize-ADSyncDeviceWriteBack -AdConnectorAccount $accountName -DomainName $domain
