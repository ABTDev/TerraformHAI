/*#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
  name = var.rg_name
}*/

resource "null_resource" "AZScript"{
provisioner "local-exec" {
   command = "az sql instance-pool create -g rg-iap-hai02u -n mipool-iap-hai02u -l eastus2 --subnet /subscriptions/f7d221ec-4738-488a-8a1c-bd6241699022/resourceGroups/rg-iap-hai02u/providers/Microsoft.Network/virtualNetworks/vnet-iap-hai02u/subnets/snet-iap-hai02u --license-type LicenseIncluded --capacity 8 -e GeneralPurpose -f Gen5 --no-wait"
    interpreter = ["az", "-command"]

}
}