# In this file, we define the names of variables we will use in main.tf
# and provide descriptions of what the variable is for.  It is best practice 
# to define the variables in a separate file from thier values to keep 
# everything portable and modular.
variable "vsphere_server" {
  description = "vsphere server for the environment"
}

variable "vsphere_user" {
  description = "vsphere server for the environment"
  sensitive = true # New in TF 0.14, this arguement will exlude this from being written to logs
}

variable "vsphere_pass" {
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
}

variable "vsphere_template" {
  description = "vsphere template or vm to clone"
}

variable "vsphere_network" {
  description = "vsphere network for deployed vms"
}

variable "domain_user" {
  description = "Domain Admin User"
  sensitive = true
}

variable "domain_pass" {
  description = "Domain Admin Password"
  sensitive = true
}

variable "domain" {
  description = "Domain to join"
}

variable "vsphere_linkedclones" {
  description = "Use linked clones to deploy"
}

variable "vm_sql" {
  description = "Prefix for SQL servers"
}

variable "vsphere_timezone" {
  description = "TimeZone to use for deployed machines"
}