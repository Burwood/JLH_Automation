# ----------------------- Azure azure.tfvars ----------------------------------
# Azure Provider variables
tenant_id        = "384c717a-6a82-4caf-bb06-b831ebf5dae6"
subscription_id  = "2c5cab23-b551-49f7-92fd-ae11d23e30a0"

# Resource variables
resourcename     = "template-rg"
region           = "Central US"
vnet_name        = "template-vnet"
vnet_address     = "10.10.0.0/16"
subnet_name      = "template-subnet"
subnet_address   = "10.10.10.0/24"
nsg_name         = "template-nsg"
nic_name         = "template-nic"
sa_repl          = "lrs" #valid types: lrs (local), rls (regional), zrs (zone redundant), grs (geo redundant), gzrs (geo zone redudant), ra-gzrs (read-access gzrs)
sa_tier          = "Standard" #valid types: General-purpose V1, General-purpose V2, Block Blob Storage, File Storage, Blob Storage
env_tags         = "terraform azure template"

# VM variables
vm_name          = "template-vm"
instance_type    = "Standard_A2_v2" #see <link to be added> for list of instance types
disk_name        = "template-disk"
publisher        = "Canonical"
offer            = "UbuntuServer"
sku              = "18.04-LTS"
vm_version       = "latest"

# Public IP variables
#pubip_name       = ""
#pubip_allocation = "dyanmic"
#nic_ip_name      = "