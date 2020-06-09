#                                                                                                                            #
#   AZURE AD - Preparing for Group Writeback                                                                                 #
#   Vorbereiten des OnPremis AD                                                                                              #
#                                                                                                                            #
#   http://c7solutions.com/2015/07/configuring-writeback-permissions-in-active-directory-for-azure-active-directory-sync     #
#                                                                                                                            #
##############################################################################################################################


$accountName = "domain\aad_account"   #[this is the account that will be used by Azure AD Connect Sync to manage objects in the directory, this is an account usually in the form of AAD_number].
$cloudGroupOU = "OU=CloudGroups,DC=contoso,DC=com"



Initialize-ADSyncGroupWriteBack -AdConnectorAccount $accountName -GroupWriteBackContainerDN $cloudGroupOU