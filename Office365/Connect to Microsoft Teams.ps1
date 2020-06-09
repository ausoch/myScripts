#
#   Connect to Microsoft Teams
#
#   Prerequisites:  Microsoft Teams PS-Modul installieren
#                   Install-Module MicrosoftTeams -force -repository psgallery
#
#############################################################################################################

$Office365credentials = Get-Credential

# Connect to  Microsoft Teams
Import-Module MicrosoftTeams
Connect-MicrosoftTeams -Credential $Office365credentials

write-host "Connecting to Microsoft Teams..."