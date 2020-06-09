#                                                                                            #
#   Script zum deaktivieren des CLUTTER in Office 365                                        #
#                                                                                            #
##############################################################################################




$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


Get-mailbox -ResultSize Unlimited | Set-Clutter -Enable $false