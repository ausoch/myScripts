$msolcred = get-credential
connect-msolservice -credential $msolcred



#   Alle Geräte
Get-MsolDevice -all

#   Gerät mit Name ...
Get-MsolDevice -Name mtftest

#   Geräte die Domain Joined sind | in Konsole gezeigt
Get-MsolDevice -all | Where-Object {$_.DeviceTrustType -eq "Domain Joined"} | select-object DisplayName,DeviceOsType,DeviceOSVersion,ApproximateLastLogonTimestamp,deviceid,lastdirsynctime | ft

#   Geräte die Domain Joined sind | in Gridview gezeigt
Get-MsolDevice -all | Where-Object {$_.DeviceTrustType -eq "Domain Joined"} | select-object DisplayName,DeviceOsType,DeviceOSVersion,ApproximateLastLogonTimestamp,deviceid,lastdirsynctime | Out-Gridview

#   Geräte die "ApproximateLastLogonTimestamp" gleich oder älter als 31.12.2016 haben und Domain Joined sind | in Gridview gezeigt
Get-MsolDevice -all | Where-Object | Where-Object {$_.ApproximateLastLogonTimestamp -le "12/31/2016" -and $_.DeviceTrustType -eq "Domain Joined"}   | select-object DisplayName,DeviceOsType,DeviceOSVersion,ApproximateLastLogonTimestamp,deviceid,lastdirsynctime | Out-Gridview

#   Alle Geräte die im Namen "MTFSFB" haben löschen
Get-MsolDevice -Name MTFSFB | Remove-MsolDevice

#   Das Geräte die mit DeviceId "c2d648ff-a10e-4ab7-8df1-99dc9bc46b44" löschen
Remove-MsolDevice -DeviceId c2d648ff-a10e-4ab7-8df1-99dc9bc46b44