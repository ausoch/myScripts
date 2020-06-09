#Assigning Licenses in Office 365

#This first command will import the Azure Active Directory module into your PowerShell session.
Import-Module MSOnline

#Capture administrative credential for future connections.
$credential = get-credential

#Establishes Online Services connection to Azure Active Directory  
Connect-MsolService -Credential $credential


#####################################################################
# Auflisten der bestehenden Lizenzen
#####################################################################

Get-MsolAccountSku


#####################################################################
# Für jeden bereits lizenzierten Benutzre Lizenzen zuweisen/anpassen
# http://windowsitpro.com/office-365/office-365-licensing-windows-powershell
#####################################################################

$myO365Sku1 = New-MsolLicenseOptions `
                                -AccountSkuId mtfbern:ENTERPRISEPACK `
                                -DisabledPlans MCOSTANDARD, EXCHANGE_S_ENTERPRISE

$unlicenseduserList = Get-MsolUser -All | where {$_.IsLicensed -eq $true}

foreach ($eachuser in $unlicenseduserList){
                                Set-MsolUserLicense `
                                  -UserPrincipalName $eachuser.UserPrincipalName `
                                  -AddLicenses mtfbern:EMS
                                Set-MsolUserLicense `
                                  -UserPrincipalName $eachuser.UserPrincipalName `
                                  -AddLicenses mtfbern:POWER_BI_STANDARD
                                Set-MsolUserLicense `
                                  -UserPrincipalName $eachuser.UserPrincipalName `
                                  -AddLicenses mtfbern:ENTERPRISEPACK
                                Set-MsolUserLicense `
                                  -UserPrincipalName $eachuser.UserPrincipalName `
                                  -LicenseOptions $myO365Sku1
                              }