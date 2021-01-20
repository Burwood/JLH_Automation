# Project Description

This project will provision and configure a Citrix Virtual Apps & Desktops environment to vSphere.  Terraform will be used to provision the VM resources and join the VMs to the domain.  Ansible will be used to install and confiugre software components on the provisioned VMs.

This is my first run at automating documentation from multiple stages.  Currently, a markdown formated document (like this readme!) is built via outputs from the Terraform script, and then running Carl Webster's CVAD powershell documentation script via Ansible.  A future project will be to append markdown output to Carl's documentation scripts instead of trying to parse and hack the text or HTML outputs.  

Process Workflow:
<p align="center"><img src=workflow.png></p>

## Pre-requisites
- A Windows Server 2019 VM template in vSphere
- An Active Directory account with permissions to join a computer to the domain
- An Active Directory account with standard Domain Users permissions
- A SMB or CIFS share with the Citrix Virtual Apps & Desktops and SQL extracted installation media

## Inventory
- 1 SQL / Cirix Licensing server
- 2 Delivery Controller / Director servers
- 2 StoreFront servers
- 1 RDSH VDA
- Builddoc.md

### Credits
A lot of the code was sourced from here and modified to meet my goals: \
https://github.com/ryancbutler/Citrix-VAD-LAB
