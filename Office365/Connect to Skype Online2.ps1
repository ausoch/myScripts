#
#   Connect to Skype Online / MS Teams
#
#
#############################################################################################################


# Connect to  Skype Online / MS Teams

Import-Module SkypeOnlineConnector
$sfbSession = New-CsOnlineSession
Import-PSSession $sfbSession
