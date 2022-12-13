######################
# General Attributes #
######################


variable "rg_name" {  
    description = "Name of the resource group to be imported"
    default     = "temp-rg"
}

variable "application" {
  description = "name for application"
  default = "iap"
}

variable "environment" {
  description = "name for environment"
  default = "hai02u"
}

variable "vnet_name" {
  description = "Name of the vnet"
  default = "vnet-hai"
}


variable "address_space" {
  description = "address space for vnet"
  default = ["10.0.0.0/25"]
}

variable "dns_servers" {
  description = "Name of the dns servers"
  default = "vnet-hai"
}

variable "nsg" {
  description = "Name of the Network Security Group"
  default = "nsg-hai"
}

variable "subnets" {
  description = "Looped Resource to create X subnet"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  default = "snet-hai"
}

variable "address_prefixes" {
  description = "address prefix for snet"
  default = ["10.0.0.0/25"]
}

variable "route_table" {
  description = "name for route table"
  default = "rt-hai"
}