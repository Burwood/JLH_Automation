#!/bin/bash
export TF_STATE=./terraform
# export secrets to variables for terraform and store them in memory
export TF_VAR_vsphere_user=$(pass vsphere_user)
export TF_VAR_vsphere_pass=$(pass vsphere_pass)                       
export TF_VAR_domain_user=$(pass domain_user)
export TF_VAR_domain_pass=$(pass domain_pass)
# begin terraform stuff
cd terraform
terraform init
terraform plan --var-file="lab.tfvars"
terraform apply --var-file="lab.tfvars" # Use the "--auto-approve" argument to not be prompted to confirm
sleep 60s
cd ..
# export terraform state
TF_STATE=./terraform/
# Run the ansible playbook 
ansible-playbook --inventory-file=..//terraform-inventory/terraform-inventory ./ansible/playbook.yml -e @./ansible/vars.yml -vvvv # "-vvvv" gives you verbose output
