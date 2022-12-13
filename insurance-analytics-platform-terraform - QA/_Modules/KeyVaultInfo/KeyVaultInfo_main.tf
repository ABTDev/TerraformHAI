# Key vault
#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
  name = var.rg_name
}

resource "azurerm_key_vault" "key_vault" { 
  name                         = var.kv_name
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  sku_name                     = var.kv_skuname
  soft_delete_retention_days   = 7
  purge_protection_enabled     = false
  tenant_id                    = var.kv_tenant_id
  enable_rbac_authorization =   var.kv_rbac_auth
   lifecycle {
    ignore_changes = [
      tags,
    ]
  }  

  depends_on = [data.azurerm_resource_group.resource_group]
}/*
output "kv_name" {
  value = data.azurerm_key_vault.key_vault.kv_name
}
output "kv_id" {
  value = data.azurerm_key_vault.key_vault.id
}*/

