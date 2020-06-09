#                                                                                            #
#   Permanently Remove Deleted Users from Office 365                                         #
#   http://exchangeserverpro.com/permanently-remove-deleted-users-office-365/                #
#                                                                                            #
##############################################################################################



Connect-MsolService

Get-MsolUser -ReturnDeletedUsers     #To see a list of the deleted users run Get-MsolUser with the -ReturnDeletedUsers switch

Remove-MsolUser -UserPrincipalName ExRemoved-3666c19e70c64e81926537d290f3e0c5@mtfbern.onmicrosoft.com -RemoveFromRecycleBin     #You can remove a specific deleted user with Remove-MsolUser and the -RemoveFromRecycleBin switch

Get-MsolUser -ReturnDeletedUsers | Remove-MsolUser -RemoveFromRecycleBin -Force     #To remove all deleted users you can pipe the Get-MsolUser output to Remove-MsolUser and add the -Force switch to avoid being prompted for each removal