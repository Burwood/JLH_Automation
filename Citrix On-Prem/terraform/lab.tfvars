
#vsphere connetion info
vsphere_server     = "vcenter.domain.com"
vsphere_datacenter = "datacenter-east"
vsphere_datastore  = "ds01"
#Resource Pool (If no resource pool place in CLUSTER/Resources format)
vsphere_rp           = "Cluster/Resources"
vsphere_folder       = "Folder/Subfolder"
vsphere_template     = "w2019_template"
#DHCP Network
vsphere_network      = "dvs-VLAN 1234"
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
vm_sql        = "sql-ctx-lab-0"


#Join domain
domain          = "domain.com"
