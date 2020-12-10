## Project Description
This expmple project will create a Citrix Virtual Apps & Desktops lab enviornment.\
Terraform is used to provision the required VMs to on-prem vSphere, name them, and join them to the domain.\
Ansible is used to install pre-requisite software packages, install Citrix components, and run Powershell scripts to configure those components.

## Inventory
- 2 Delivery Controllers with Director
- 2 StoreFront Servers
- 1 SQL Server with Citrix Licensing
- 1 2019 RDSH Host with VDA installed

## Build.sh breakdown
`terraform init` - Terraform reads all the .tf files to identify needed plugins and modules and downloads them to the current project directory.

`terraform plan --var-file="<variable file>"` - Terraform outputs what it is going to do based on all the project files, but doesn't execute the project. `-out=path` will save the output to a file.

`terraform apply --var-file="<variable file>"` - Terraform will execute the plan. Insert `--auto-approve' if you do not want to be prompted for confirmation.

 **NOTE - If you are just using Terraform, delete or comment out everything after the `terraform apply` command.**

`sleep 60s` - Pause before executing the Ansible playbook.

`TF_STATE=./terraform/` - Terraform-inventory will parse the Terraform state and parse it so Ansible can read it as an Ansible inventory.

`ansible-playbook --inventory-file=../terraform-inventory/terraform-inventory ./ansible/playbook-async.yml -e @./ansible/vars.yml` - Run the Ansible playbook, referencing the inventory file and the variable file.

## Destroy.sh breakdown
`terraform destroy --var-file="<variable file>"` - Terraform destroys everything in the plan.  This is equivilent to powering off the VMs, deleting them from disk in vSphere, and deleting the VM folder.  A future version should run an Ansible playbook to clean up AD accounts.
  
## Terraform and Ansible info and instructions to come!

## References
https://www.terraform.io/docs/commands \
https://github.com/adammck/terraform-inventory \
https://github.com/ryancbutler/Citrix-VAD-LAB (The source I stole everything from!)
