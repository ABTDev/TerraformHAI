######################
# General Attributes #
######################
variable "rg_name" {  
    description = "Name of the resource group to be imported"
    default     = "temp-rg"
}

# All defaults can be overwritten when the module is called in the primary "Main.tf" file
###########################
# Azure Analysis Services #
###########################
variable "aas_name" {
  description = "Name of the Azure Analysis Services"
  default     = "aaserv"
}
variable "aas_sku" {
  description = "SKU of the Azure Analysis Services"
  default     = "B2"
}
variable "aas_admin_user" {
  description = "admin user for Analysis Services"
  default     = "anaserveradmin"
}

variable "aas_powerbi" {
  description = "Indicates if the Power BI service is allowed"
  default     = false
}