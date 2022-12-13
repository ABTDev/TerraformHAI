# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
 
}

provider "azurerm" {
  features {}

    skip_provider_registration = true
  
}
################
# Data Imports #
################
# Existing Resource Group
data "azurerm_resource_group" "iap_rg" {
  name = "rg-${var.application}-${var.environment}"
}

data "azurerm_client_config" "current" {
  
}

#####################
# Key Vault  #
#####################
module "iap_keyvault" { 
  source     = "../_Modules/KeyVaultInfo"
  kv_name    = "vlt-${var.application}01-${var.environment}" 
  rg_name    = data.azurerm_resource_group.iap_rg.name
  kv_tenant_id = data.azurerm_client_config.current.tenant_id
   kv_skuname = "standard"
  kv_rbac_auth = "true"
  
  depends_on = [data.azurerm_resource_group.iap_rg, data.azurerm_client_config.current]
}

#####################
# Logic App #
#####################
module "iap_logicapp" { 
  source     = "../_Modules/LogicApps"
  logic_app_name    = "lapp-${var.application}-${var.environment}" 
  rg_name    = data.azurerm_resource_group.iap_rg.name
 
 
  depends_on = [data.azurerm_resource_group.iap_rg]
}
#############################
# Storage Account Data Lake #
#############################
module "iap_storage_account" {
  source  = "../_Modules/StorageAccount"
  rg_name                   = data.azurerm_resource_group.iap_rg.name 
  name                      = "sax${var.application}x${var.environment}"
  account_tier              = "Standard"  #Default
  account_replication_type  = "LRS"       #Default
  account_kind              = "StorageV2" #Default, needed for Data Lake
  is_hns_enabled            = true        #Default, needed for Data Lake
  min_tls_version           = "TLS1_2"    #Default
  filesystems               = var.filesystems 

  depends_on = [data.azurerm_resource_group.iap_rg]    
}


#####################
# Azure Data Factory #
#####################
module "iap_adf" { 
  source     = "../_Modules/ADF"
  adf_name    = "adf-${var.application}-${var.environment}" 
  rg_name    = data.azurerm_resource_group.iap_rg.name
 
   depends_on = [data.azurerm_resource_group.iap_rg]
}
###########################
# Azure Analysis Services #
###########################
module "iap_aas" {
  source  = "../_Modules/AAS"
  rg_name               = data.azurerm_resource_group.iap_rg.name 
  aas_name              = "${var.environment}${var.application}anserv01"
  aas_sku               = "B1"
  aas_admin_user           = ["atiwari-contractor@housingcenter.com"]
  aas_powerbi           = false
  
  depends_on = [data.azurerm_resource_group.iap_rg] 
}



###########################
# Deploying Network #
###########################

# Virtual network within the resource group

module "iap_vnet" {
  source  = "../_Modules/network"
  rg_name               = data.azurerm_resource_group.iap_rg.name 
  vnet_name                  = "vnet-${var.application}-${var.environment}"
  address_space       = ["10.50.160.0/23"]
  dns_servers         = ["8.8.8.8", "8.8.4.4"]
  subnets = ["FrontEnd","BackEnd", "VnetIntegration"]
  depends_on = [data.azurerm_resource_group.iap_rg] 

}
/*
module "iap_snet" {
    source  = "../_Modules/network"
    rg_name               = data.azurerm_resource_group.iap_rg.name
    vnet_name         = module.iap_keyvault
    depends_on = [data.azurerm_resource_group.iap_rg] 
  subnets = {
    subnet_1 = {
      subnet_name = "FrontEnd"
      address_prefixes  = ["10.50.160.0/25"]
      service_delegation = false
    }
    subnet_2 = {
      subnet_name = "BackEnd"
      address_prefixes  = ["10.50.160.128/25"]
      service_delegation = false
    }

  subnet_3 = {
      subnet_name = "VnetIntegration"
      address_prefixes  = ["10.50.161.0/25"]
      service_delegation = true
    }
    
  }
}
    


###############################
# Azure Managed Instance Pool #
###############################
module "iap_instancepool" { 
  source     = "../_Modules/InstancePool"
  
}
*/

