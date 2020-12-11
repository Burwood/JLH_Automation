# Define the provider (vsphere, aws, gcp, azure, etc.) and how to connect
provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# The data source declarations define important characteristics about resources that we want to create.  Here we define the datacenter, datastore, resource pool, source template, and network
data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_rp}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# In this example project, the folder doesn't exist yet.  So instead of type "data" we define it as type "resource".  Terraform will interpret this as something it needs to create.  Terraform will process all resources and automatically identify that this is a prerequisite, as it is listed inside the virutal machine resources.
resource "vsphere_folder" "folder" {
  path          = "${var.vsphere_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# We are telling Terraform to create resource type "vsphere_virtual_machine".  This is a predefined resource type that the vsphere provider registry knows about.  "ddc" represents a locally significant name to identify this resource elsewhere as needed.  I like to think of it as a group tag, as we might be creating 1 or 1000 vms with resource block.
resource "vsphere_virtual_machine" "ddc" {
  name             = "${var.vm_ddc}${count.index + 1}" # this will call the variable "vm_ddc" which has the hostname prefix of "ddc-ctx-lab-0" in lab.tfvars.  Count index starts at "0", so we will add 1 to get vm01, vm02 etc. instaead of vm00 vm01... 
  count            = 2 # number of items to create
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${vsphere_folder.folder.path}" # reference to the vsphere_folder resource
  num_cpus         = 2
  memory           = 4096
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
# becasue this is a linked-clone to the template VM, it inherits the disk info from the template.  
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    linked_clone = "${var.vsphere_linkedclones}"

    customize {
      windows_options {
        computer_name         = "${var.vm_ddc}${count.index + 1}"
        join_domain           = "${var.domain}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.vsphere_timezone}"
      }

      network_interface {}


    }
  }
}

# same stuff here, except we are giving this resrouce the name "storefront" and calling a different variable for generating it's inventory name and hostname
resource "vsphere_virtual_machine" "storefront" {
  name             = "${var.vm_storefront}${count.index + 1}"
  count            = 2
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${vsphere_folder.folder.path}"
  num_cpus         = 2
  memory           = 2048
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }


  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    linked_clone = "${var.vsphere_linkedclones}"

    customize {
      windows_options {
        computer_name         = "${var.vm_storefront}${count.index + 1}"
        join_domain           = "${var.domain}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.vsphere_timezone}"
      }

      network_interface {}

    }
  }
}

# Since we are only creating 1 vm in this resoruce block, it was chosen to have the full VM name be defined in the variable and omit the count arguement.  Optionally, we could have used a similar format as the preceeding resource blocks and just given it a count value of 1.  The VDA resource block below illustrates just that.
resource "vsphere_virtual_machine" "sql" {
  name             = "${var.vm_sql}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${vsphere_folder.folder.path}"
  num_cpus         = 2
  memory           = 4096
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }


  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    linked_clone = "${var.vsphere_linkedclones}"

    customize {
      windows_options {
        computer_name         = "${var.vm_sql}"
        join_domain           = "${var.domain}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.vsphere_timezone}"
      }

      network_interface {}


    }
  }
}

resource "vsphere_virtual_machine" "vda" {
  name             = "${var.vm_vda}${count.index + 1}"
  count            = 1
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${vsphere_folder.folder.path}"
  num_cpus         = 2
  memory           = 4096
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }


  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    linked_clone = "${var.vsphere_linkedclones}"

    customize {
      windows_options {
        computer_name         = "${var.vm_vda}${count.index + 1}"
        join_domain           = "${var.domain}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.vsphere_timezone}"
      }

      network_interface {}

    }
  }
}
