######################
# General Attributes #
######################

variable "rg_name" {  
    description = "Name of the resource group to be imported"
    default     = "temp-rg"
}
variable "command" {  
    description = "command to be executed"
    default     = "temp"
}