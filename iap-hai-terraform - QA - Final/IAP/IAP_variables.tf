#####################
# General Variables #
#####################
variable "region" {
  description = "Azure Region location"
}
variable "region_shortname" {
  description = "Azure Region shortname used for naming"
}
variable "environment" {
  description = "Environment reference"
}
variable "environment_reference" {
  description = "Environment reference, but all CAP casing and not the same as environment"
}
variable "application" {
  description = "IAP application"
}

####################
# Storage Services #
####################
variable "filesystems" {
  description = "Looping variable for X number of filesystems (containers)"
}

###############
# SQL Related #
###############
variable "databases" { 
  description = "Looping variable for X number of databases"
}
