variable "vsphere_server" {
  description = "vsphere server for the environment"
}

variable "cvad_lab_vsphere_user" {
  description = "vsphere server for the environment"
  sensitive = true
}

variable "cvad_lab_vsphere_pass" {
  description = "vsphere server password for the environment"
  sensitive = true
}

variable "vsphere_datacenter" {
  description = "vsphere datacenter"
}

variable "vsphere_datastore" {
  description = "vsphere datastore to deploy"
}

variable "vsphere_rp" {
  description = "vsphere resource pool"
}

variable "vsphere_folder" {
  description = "vsphere folder path"
  type        = string
}

variable "vsphere_template" {
  description = "vsphere template or vm to clone"
}

variable "vsphere_network" {
  description = "vsphere network for deployed vms"
}


variable "cvad_lab_domain_user" {
  description = "Domain Admin User"
  sensitive = true
}

variable "cvad_lab_domain_pass" {
  description = "Domain Admin Password"
  sensitive = true
}

variable "domain" {
  description = "Domain to join"
}

variable "vsphere_linkedclones" {
  description = "Use linked clones to deploy"
}


variable "vm_storefront" {
  description = "Prefix for Storefront servers"
}

variable "vm_ddc" {
  description = "Prefix for DDC servers"
}
variable "vm_sql" {
  description = "Name for SQL and license server"
}

variable "vm_vda" {
  description = "Prefix for VDA server"
}

variable "vsphere_timezone" {
  description = "TimeZone to use for deployed machines"
}
