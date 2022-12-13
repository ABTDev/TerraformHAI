##Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
    name = var.rg_name
}

# Create a Network Security Group
resource "azurerm_network_security_group" "nsg" {
  #for_each            = var.subnets
  name                = "nsg-${var.application}-${var.environment}"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  location                = data.azurerm_resource_group.resource_group.location
    
}

resource "azurerm_network_security_rule" "allow_management_inbound" {
  name                        = "allow_management_inbound"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  name                        = "allow_management_outbound"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "12000"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
  name                        = "allow_misubnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "deny_all_outbound" {
  name                        = "deny_all_outbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  #for_each                  = var.subnets
  subnet_id                 = "${azurerm_subnet.subnet_3.id}"
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [azurerm_subnet.subnet_3]
}
#Create Vnet.

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  address_space       = var.address_space
  lifecycle {
    ignore_changes = [
      tags,
    ]
}
 depends_on = [data.azurerm_resource_group.resource_group]
  
}

#Create FrontEnd Subnet.
resource "azurerm_subnet" "subnet_1" {
  #for_each        = var.address_prefix
  name            = "FrontEnd"
  resource_group_name  = data.azurerm_resource_group.resource_group.name 
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.50.160.0/25"]
  lifecycle {
    ignore_changes = [
      
    ]
    }
  depends_on = [data.azurerm_resource_group.resource_group, azurerm_virtual_network.vnet]

}

#Create BackEnd Subnet.
resource "azurerm_subnet" "subnet_2" {
  #for_each        = var.address_prefix
  name            = "BackEnd"
  resource_group_name  = data.azurerm_resource_group.resource_group.name 
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.50.160.128/25"]
  lifecycle {
    ignore_changes = [
      
    ]
    }
  depends_on = [data.azurerm_resource_group.resource_group, azurerm_virtual_network.vnet]
}


#Create VnetIntegration Subnet.
resource "azurerm_subnet" "subnet_3" {
  #for_each        = var.address_prefix
  name            = "VnetIntegration"
  resource_group_name  = data.azurerm_resource_group.resource_group.name 
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.50.161.0/25"]
  lifecycle {
    ignore_changes = [
      
    ]
    }
  depends_on = [data.azurerm_resource_group.resource_group, azurerm_virtual_network.vnet]
  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
  
  
}



resource "azurerm_route_table" "rt" {
  #for_each                  = var.subnets
  depends_on                    = [azurerm_subnet.subnet_3]
  name                          = "rt-${var.application}-${var.environment}"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  location                = data.azurerm_resource_group.resource_group.location
  disable_bgp_route_propagation = false
  lifecycle {
    ignore_changes = [
      
    ]
  }
}

resource "azurerm_subnet_route_table_association" "rtassoc" {
  #for_each                  = var.subnets
  subnet_id                 = "${azurerm_subnet.subnet_3.id}"
  route_table_id = azurerm_route_table.rt.id
   depends_on = [azurerm_subnet.subnet_3]
}
