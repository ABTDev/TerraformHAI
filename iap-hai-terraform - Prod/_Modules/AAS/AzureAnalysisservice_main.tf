data "azurerm_resource_group" "resource_group" {
    name = var.rg_name
}

resource "azurerm_analysis_services_server" "aas" {
  #count                     = var.analysis == "true" ? 1 : 0
  name                         = var.aas_name
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  sku                       = var.aas_sku
  admin_users               = var.aas_admin_user
  enable_power_bi_service   = var.aas_powerbi
     lifecycle {
    ignore_changes = [
      tags,
    ]
  }  
  depends_on           = [data.azurerm_resource_group.resource_group]
}
