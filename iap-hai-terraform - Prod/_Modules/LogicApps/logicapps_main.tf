# Logic Apps
#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
  name = var.rg_name
}

resource "azurerm_logic_app_workflow" "logic_app" { 
  name                         = var.logic_app_name
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  
   lifecycle {
    ignore_changes = [
      tags,
    ]
  }  

  depends_on = [data.azurerm_resource_group.resource_group]
}
/*
output "logic_app_name" {
  value = data.azurerm_logic_app_workflow.logic_app.name
}
output "logic_app_id" {
  value = data.azurerm_logic_app_workflow.logic_app.id
}
*/

