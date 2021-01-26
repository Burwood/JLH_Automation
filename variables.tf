# ---------------- Azure variables.tf ----------------------
# Azure Provider variables 
variable "tenant_id" {
  type = string
  description = "Azure Tenant ID" 
}

variable "subscription_id" {
  type = string
  description = "Azure Subscription ID" 
}

# Resource variables
variable "resourcename" {
  default = "myresourcegroup"
}

variable "region" {
  type = string
  description = "Azure region" 
}

variable "vnet_name" {
  type = string
  description = "Virtual Network name" 
}

variable "vnet_address" {
  type = string
  description = "Virtual Network base address space" 
}

variable "subnet_name" {
  type = string
  description = "Subnet name" 
}

variable "subnet_address" {
  type = string
  description = "Subnet address space" 
}

variable "nsg_name" {
  type = string
  description = "Network Security Group name" 
}

variable "nic_name" {
  type = string
  description = "Network Interface name" 
}

variable "sa_repl" {
  type = string
  description = "Storage Account Replication Type" 
}

variable "sa_tier" {
  type = string
  description = "Storage Account Tier Type" 
}

variable "env_tags" {
  type = string
  description = "Environment tags" 
}

# VM variables
variable "vm_name" {
  type = string
  description = "Virtual Machine name"
}

variable "instance_type" {
  type = string
  description = "Azure instance type"
}

variable "disk_name" {
  type = string
  description = "VM disk name"
}

variable "publisher" {
  type = string
  description = "os publisher"
}

variable "offer" {
  type = string
  description = "title of os sku"
}

variable "sku" {
  type = string
  description = "version of os"
}

variable "vm_version" {
  type = string
  description = "version of sku image"
}

variable "adminuser" {
  type = string
  description = "Account to create on VM"
}

variable "adminpass" {
  type = string
  description = "Password for admin user"
}