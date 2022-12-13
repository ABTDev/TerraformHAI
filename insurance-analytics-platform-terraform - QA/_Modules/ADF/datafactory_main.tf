#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
  name = var.rg_name
}

resource "azurerm_data_factory" "adf" {
  name                         = var.adf_name
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  identity {
    type = "SystemAssigned"
  }
  lifecycle {
        ignore_changes = [
        tags,
        ]
    }  
    depends_on               = [data.azurerm_resource_group.resource_group]
}
output "adf_name" {
    value = azurerm_data_factory.adf.name
}
output "adf_id" {
    value = azurerm_data_factory.adf.id
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "adf_shir" {
  name            = "shir-${var.application}${var.environment}"
  data_factory_id = azurerm_data_factory.adf.id
}