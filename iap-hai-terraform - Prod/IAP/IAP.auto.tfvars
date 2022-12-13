#####################
# General Variables #
#####################
region                = "eastus2"
region_shortname      = "eus2"
environment           = "hai02u"
environment_reference = "nonprod"
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

###############
# SQL Related #
###############
databases = {
    Secura_DataLake = {
        db_name           = "Secura_DataLake"
        min_capacity      = 1        
        db_max_gb         = 15
        db_sku_name       = "GP_S_Gen5_8"
        db_zone_redundant = false
    },
    IAP_Audit = {
        db_name           = "IAP_Audit"
        min_capacity      = 1
        db_max_gb         = 15
        db_sku_name       = "GP_S_Gen5_1"
        db_zone_redundant = false
    }
}