#####################
# General Variables #
#####################
region                = "eastus2"
region_shortname      = "eus2"
environment           = "hai02p"
environment_reference = "prod"
application           = "iap"

####################
# Storage Services #
####################
filesystems = {
    inbound = {
        fs_name = "inbound"
    }, 
    outbound = {
        fs_name = "outbound"
    }, 
    Logs = {
        fs_name = "logs"
    }       
}
