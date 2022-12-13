######################
# General Attributes #
######################
variable "adf_name" {
  description = "Name of the Data Factory"
  default = "temp-adf"
}
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
  default = "uat"
}