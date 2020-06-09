#                                                                                            #
#   Ändern der Maildomäne einer Office 365 Gruppe                                      #
#                                                                                            #
##############################################################################################


#   Connect to Exchnage Online
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


#   Anzeigen von allen Gruppen
Get-UnifiedGroup | fl name

#   Anzeigen von Details der Gruppe WirelessGasthofTiefenau_9ad0352e7c
Get-UnifiedGroup -Identity "MTFCloud_1270f12cdd" |fl

#   E-Mailadresse anpassen
Set-UnifiedGroup -Identity "MTFCloud_1270f12cdd" -EmailAddresses @{Add="smtp:MTFCloud@groups.mtf-be.ch"}   #Hinzufügen einer E-Mailadresse zur entsprechenden Gruppe
Set-UnifiedGroup -Identity "MTFCloud_1270f12cdd" -PrimarySmtpAddress MTFCloud@groups.mtf-be.ch   #Primäre E-Mailadresse der entsprechenden Gruppe festlegen
