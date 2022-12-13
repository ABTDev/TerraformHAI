######################
# General Attributes #
######################
variable "rg_name" {  
  description = "Name of the resource group to be imported"
  default     = "temp-rg"
}

# All defaults can be overwritten when the module is called in the primary "Main.tf" file
###################
# Storage Account #
###################
variable "name" {
  description = "Name of the Storage Account"
  default     = "temp-name"
}
variable "account_tier" {
  description = "Account Tier of the Storage Account"
  default     = "Standard"
}
variable "account_replication_type" {
  description = "Account Replciation Type of the Storage Account"
  default     = "LRS"
}
variable "account_kind" {
  description = "Account Kind of the Storage Account"
  default     = "StorageV2"
}
variable "is_hns_enabled" {
  description = "Boolean if Hierarchical Namespace is enabled on the Storage Account. Only applicable for Gen 2 Data Lake Storage"
  default     = "true"
}
variable "min_tls_version" {
  description = "Supported minimum TLS version for the Storage Account"
  default     = "TLS1_2"
}

##############################
# Storage Account Filesystem #
##############################
variable "filesystems" {
  description = "Looping variable for X number of filesystems (containers)"
  default = {
  }
}