#Deploy  instance Pool

New-AzSqlInstancePool -ResourceGroupName rg-iap-hai02u -Name mipool-iap-hai02u  -Location eastus2 -SubnetId "/subscriptions/f7d221ec-4738-488a-8a1c-bd6241699022/resourceGroups/rg-iap-hai02u/providers/Microsoft.Network/virtualNetworks/vnet-iap-hai02u/subnets/VnetIntegration" -VCore 8 -Edition GeneralPurpose -ComputeGeneration Gen5 -LicenseType LicenseIncluded

#Drop Managed Instance :
Remove-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u 
Remove-AzSqlInstance -Name hai02u-iapmi02 -ResourceGroupName rg-iap-hai02u 

#Drop Managed Instance Pool:
Remove-AzSqlInstancePool -ResourceGroupName rg-iap-hai02u -Name mipool-iap-hai02u

#Deploy Managed SQL instance in instance Pool
New-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u -Location eastus2 -AdministratorCredential (Get-Credential) -SubnetId "/subscriptions/f7d221ec-4738-488a-8a1c-bd6241699022/resourceGroups/rg-iap-hai02u/providers/Microsoft.Network/virtualNetworks/vnet-iap-hai02u/subnets/VnetIntegration" -LicenseType LicenseIncluded -StorageSizeInGB 2048 -VCore 4 -ComputeGeneration Gen5 -Edition GeneralPurpose -InstancePoolName mipool-iap-hai02u -MinimalTlsVersion 1.2 -assignidentity -Identitytype SystemAssigned .\_Modules
B1tazLsw1Zu7L@e

#Deploy Managed SQL instance in instance Pool
New-AzSqlInstance -Name hai02u-iapmi02 -ResourceGroupName rg-iap-hai02u -Location eastus2 -AdministratorCredential (Get-Credential) -SubnetId "/subscriptions/f7d221ec-4738-488a-8a1c-bd6241699022/resourceGroups/rg-iap-hai02u/providers/Microsoft.Network/virtualNetworks/vnet-iap-hai02u/subnets/VnetIntegration" -LicenseType LicenseIncluded -StorageSizeInGB 2048 -VCore 4 -ComputeGeneration Gen5 -Edition GeneralPurpose -InstancePoolName mipool-iap-hai02u -MinimalTlsVersion 1.2 -assignidentity -Identitytype SystemAssigned

B1tazLsw1Zu7L@e

DTAUser - C9idrum5Sav9
automation_user - r8keprEp*5cri


#Get the Minimal TLS Version property
(Get-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u).MinimalTlsVersion

# Update Minimal TLS Version Property
Set-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u -MinimalTlsVersion "1.2"

# get IdentityType 
(Get-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u ).IdentityType

# change IdentityType 
Set-AzSqlInstance -Name hai02u-iapmi01 -ResourceGroupName rg-iap-hai02u -assignidentity
Set-AzSqlInstance -Name hai02u-iapmi02 -ResourceGroupName rg-iap-hai02u -assignidentity

Get-AzADServicePrincipal -DisplayName hai02u-iapmi01

#Create Database in Azure SQL Managed Instance
New-AzSqlInstanceDatabase -Name "Audit" -InstanceName "hai02u-iapmi01" -ResourceGroupName "rg-iap-hai02u"

New-AzSqlInstanceDatabase -Name "DataLake" -InstanceName "hai02u-iapmi01" -ResourceGroupName "rg-iap-hai02u"

New-AzSqlInstanceDatabase -Name "Meta4Ingest" -InstanceName "hai02u-iapmi01" -ResourceGroupName "rg-iap-hai02u"

New-AzSqlInstanceDatabase -Name "IAP" -InstanceName "hai02u-iapmi02" -ResourceGroupName "rg-iap-hai02u"

#enable Public endpoint 
Set-AzSqlInstance -ResourceGroupName rg-iap-hai02u -Name hai02u-iapmi02 -PublicDataEndpointEnabled $true -force

Set-AzSqlInstance -ResourceGroupName rg-iap-hai02u -Name hai02u-iapmi01 -PublicDataEndpointEnabled $true -force