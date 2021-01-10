# vsphere connetion info
vsphere_server     = "vcenter.domain.com"
vsphere_datacenter = "datacenter-east"
vsphere_datastore  = "dc-east-ds001"
# Resource Pool (If no resource pool place in CLUSTER/Resources format)
vsphere_rp           = "cluster/Resources"
vsphere_folder       = "path/to/folder"
vsphere_template     = "w2019_template"
vsphere_network      = "dvs-VLAN 2004"
# Use linked clones.(Requires a single snapshot on the VM)
vsphere_linkedclones = true

# https://docs.microsoft.com/en-us/previous-versions/windows/embedded/ms912391(v=winembedded.11)?redirectedfrom=MSDN
# 004	Pacific Standard Time
# 010	Mountain Standard Time
# 015	U.S. Mountain Standard Time (Arizona)
# 020	Central Standard Time
# 035	Eastern Standard Time
# 040	U.S. Eastern Standard Time (Indiana)
vsphere_timezone = 020

# VM naming prefix
vm_sql = "sql0" #will become sql01, sql02, etc.

# Join domain
domain          = "domain.com"
