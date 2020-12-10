## Project Description
This expmple project will create a Citrix Virtual Apps & Desktops lab enviornment.\
Terraform is used to provision the required VMs to on-prem vSphere, name them, and join them to the domain.\
Ansible is used to install pre-requisite software packages, install Citrix components, and run Powershell scripts to configure those components.

## Inventory
- 2 Delivery Controllers with Director
- 2 StoreFront Servers
- 1 SQL Server with Citrix Licensing
- 1 2019 RDSH Host with VDA installed

