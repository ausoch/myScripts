$azureUserName="<USERNAME>" 

$azurePassword='<PASSWORD>’ 

$azureSecurePassword = ConvertTo-SecureString $azurePassword -AsPlainText -Force 

$azureCreds = New-Object System.Management.Automation.PSCredential $azureUserName, $azureSecurePassword 

Register-AzureADConne<ctHealthADDSAgent -Credential $azureCreds