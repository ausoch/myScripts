Import-Module SkypeOnlineConnector
$sfbSession = New-CsOnlineSession
Import-PSSession $sfbSession

get-csonlineuser | ft DisplayName,onprem*, sip*
get-csonlineuser | ft DisplayName,ServiceInstance,RegistrarPool,HostingProvider,OriginatingServer,OnPremOptionFlags,SipProxyAddress,SipAddress

get-csonlineuser -Identity "testuser@jumbo.ch" | fl

Get-CsOnlineUser | Where-Object {$_.UserPrincipalName -Match "@jumbo.ch"} | ft DisplayName,ServiceInstance,RegistrarPool,HostingProvider,OriginatingServer,OnPremOptionFlags,SipProxyAddress,SipAddress

Get-CsOnlineUser | Where-Object {$_.UserPrincipalName -Match "@jumbo.ch"} | ft DisplayName,TeamsAppSetupPolicy

Grant-CsTeamsAppSetupPolicy -identity "pascal.hafen@jumbo.ch" -PolicyName "Jumbo-RemoteWorker"

Get-CsOnlineUser | Where-Object {$_.UserPrincipalName -Match "@jumbo.ch"} | Grant-CsTeamsAppSetupPolicy -PolicyName "Jumbo-RemoteWorker"


Get-CsonlineUser
