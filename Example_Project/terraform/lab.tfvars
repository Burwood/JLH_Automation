# Ideally, our secrets would be encrypted and stored externally from the project

#vsphere connetion info
vsphere_server     = "vcenter.domain.com"
vsphere_user       = "admin@domain.com"
vsphere_password   = "password"
vsphere_datacenter = "dc-east"
vsphere_datastore  = "tier0-storage"
#Resource Pool (If no resource pool place in CLUSTER/Resources format)
vsphere_rp           = "gold-resources"
vsphere_folder       = "lab"
vsphere_template     = "w2019_template"
#DHCP Network
vsphere_network      = "lab-net"
#Use linked clones.(Requires a single snapshot on the VM)
vsphere_linkedclones = true

# https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)?redirectedfrom=MSDN
# 004	Pacific Standard Time
# 010	Mountain Standard Time
# 015	U.S. Mountain Standard Time (Arizona)
# 020	Central Standard Time
# 035	Eastern Standard Time
# 040	U.S. Eastern Standard Time (Indiana)
vsphere_timezone = 020

#VM naming
#Prefix
vm_storefront = "sf-ctx-lab-0"
vm_ddc        = "ddc-ctx-lab-0"
vm_vda        = "vda-ctx-lab-0"
#Actual Name
vm_sql = "sql-ctx-lab-01"

#Join domain
domain_user     = "admin@domain.com"
domain_password = "password"
domain          = "domain.com"
