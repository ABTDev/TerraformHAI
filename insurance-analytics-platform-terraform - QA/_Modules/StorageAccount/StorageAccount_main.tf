#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
    name = var.rg_name
}

####################
# Storage Services #
####################
# Create Azure Storage Account 
resource "azurerm_storage_account" "storage_account" {
    resource_group_name = data.azurerm_resource_group.resource_group.name
    location            = data.azurerm_resource_group.resource_group.location

    name                     = var.name 
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
    account_kind             = var.account_kind 
    is_hns_enabled           = var.is_hns_enabled 
    min_tls_version          = var.min_tls_version 
    lifecycle {
        ignore_changes = [
        tags,
        ]
    }  
    depends_on               = [data.azurerm_resource_group.resource_group]
}
output "storage_account_name" {
    value = azurerm_storage_account.storage_account.name
}
output "storage_account_id" {
    value = azurerm_storage_account.storage_account.id
}

##############################
# Data Lake Gen 2 FileSystem #
##############################
resource "azurerm_storage_data_lake_gen2_filesystem" "filesystem" {
    for_each           = var.filesystems
    name               = each.value["fs_name"]
    storage_account_id = azurerm_storage_account.storage_account.id
    
    depends_on         = [azurerm_storage_account.storage_account]
}
output "filesystem_id" {
    value = { for id, filesystem_value in azurerm_storage_data_lake_gen2_filesystem.filesystem : id => filesystem_value.id }
}