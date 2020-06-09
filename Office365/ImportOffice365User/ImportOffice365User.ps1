$credential = get-credential
Import-Module MSOnline
Connect-MsolService -Credential $credential


$Users= Import-CSV c:\Temp\Office365User.csv
$Users | ForEach-Object {New-MsolUser -FirstName $_.FirstName -LastName $_.LastName -Title $_.Title -Department $_.Department -StreetAddress $_.StreetAddress -PostalCode $_.PostalCode -City $_.city -State $_.State -Country $_.Country -PhoneNumber $_.PhoneNumber -Fax $_.Fax -MobilePhone $_.MobilePhone -Password $_.Password -UserPrincipalName $_.UserPrincipalName  -DisplayName $_.DisplayName }
