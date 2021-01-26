# ---------------------- Azure main.tf --------------------------------
provider "azurerm" {
  tenant_id         = var.tenant_id
  subscription_id   = var.subscription_id
  features {}
}

resource "azurerm_resource_group" "resourcegroup" {
        name        = var.resourcename
        location    = var.region

        tags = {
          environment = var.env_tags
        }
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    address_space       = [var.vnet_address]
    location            = var.region
    resource_group_name = azurerm_resource_group.resourcegroup.name

    tags = {
        environment = var.env_tags
    }
}

resource "azurerm_subnet" "subnet" {
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.resourcegroup.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.subnet_address]
}

#resource "azurerm_public_ip" "pubip" {
#    name                         = var.pubip_name
#    location                     = var.region
#    resource_group_name          = azurerm_resource_group.resourcegroup.name
#    public_ip_address_allocation = var.pubip_allocation
#
#    tags = {
#        environment = var.env_tags
#    }
#}

resource "azurerm_network_security_group" "nsg" {
    name                = var.nsg_name
    location            = var.region
    resource_group_name = azurerm_resource_group.resourcegroup.name

    security_rule {
        name                       = "ssh"
        priority                   = 1001
        direction                  = "inbound"
        access                     = "allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.env_tags
    }
}

resource "azurerm_network_interface" "nic" {
    name                = var.nic_name
    location            = var.region
    resource_group_name = azurerm_resource_group.resourcegroup.name

    ip_configuration {
        name                          = "template-ip"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "dynamic"
        # public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = var.env_tags
    }
}

resource "random_id" "randomid" {
    keepers = {
        # generate a new id only when a new resource group is defined
        resource_group = azurerm_resource_group.resourcegroup.name
    }
    byte_length = 8
}

resource "azurerm_storage_account" "sa" {
    name                     = "diag${random_id.randomid.hex}"
    resource_group_name      = azurerm_resource_group.resourcegroup.name
    location                 = var.region
    account_replication_type = var.sa_repl
    account_tier             = var.sa_tier

    tags = {
        environment = var.env_tags
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
    name                  = var.vm_name
    location              = var.region
    resource_group_name   = azurerm_resource_group.resourcegroup.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    size                  = var.instance_type
    admin_username        = var.adminuser
    admin_password        = var.adminpass
    disable_password_authentication = false

    os_disk {
        name              = var.disk_name
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.publisher
        offer     = var.offer
        sku       = var.sku
        version   = var.vm_version
    }

    tags = {
        environment = var.env_tags
    }
}

resource "azurerm_windows_virtual_machine" "example" {
    name                = "example-machine"
    resource_group_name = azurerm_resource_group.example.name
    location            = azurerm_resource_group.example.location
    size                = "Standard_F2"
    admin_username      = "adminuser"
    admin_password      = "P@$$w0rd1234!"

    network_interface_ids = [
        azurerm_network_interface.example.id,
    ]

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
}
