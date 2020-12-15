# Define the provider (vsphere, aws, gcp, azure, etc.) and how to connect
provider "vsphere" {
  user           = var.cvad_lab_vsphere_user
  password       = var.cvad_lab_vsphere_pass
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# The data source declarations define important characteristics about 
# resources that we want to create.  Here we define the datacenter, 
# datastore, resource pool, source template, and network
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_rp
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# In this example project, the folder doesn't exist yet.  So instead of 
# type "data" we define it as type "resource".  Terraform will interpret
# this as something it needs to create.  Terraform will process all 
# resources and automatically identify that this is a prerequisite, 
# as it is listed inside the virutal machine resources.
resource "vsphere_folder" "folder" {
  path          = var.vsphere_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# We are telling Terraform to create resource type "vsphere_virtual_machine".
#This is a predefined resource type that the vsphere provider registry knows about.
# "sql" represents a locally significant name to identify this resource elsewhere 
# as needed.  I like to think of it as a group tag, as we might be creating 
# 1 or 1000 vms with resource block.
resource "vsphere_virtual_machine" "sql" {
  name             = "${var.vm_sql}${count.index + 1}" 
  # this will call the variable "vm_sql" which has the hostname prefix of 
  # "sql0" in lab.tfvars.  Count index starts at "0", so we will 
  # add 1 to get sql01, sql02 etc. instaead of sql00 sql01... 
  count            = 1 # number of items to create
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path # reference to the vsphere_folder resource
  num_cpus         = 2
  memory           = 4096
  guest_id         = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  # becasue this is a linked-clone to the template VM
  # it inherits the disk info from the template.  
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    linked_clone = var.vsphere_linkedclones

    customize {
      windows_options {
        computer_name         = var.vm_sql
        join_domain           = var.domain
        domain_admin_user     = var.domain_user
        domain_admin_password = var.domain_pass
        time_zone             = var.vsphere_timezone
      }

      network_interface {}


    }
  }
}