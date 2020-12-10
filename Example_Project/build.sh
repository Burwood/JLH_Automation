#!/bin/bash
export TF_STATE=./terraform
cd terraform
terraform init
terraform plan --var-file="lab.tfvars"
# terraform apply --auto-approve --var-file="lab.tfvars"
terraform apply --var-file="lab.tfvars"
sleep 60s
cd ..
TF_STATE=./terraform/
# Run the playbook (serial)
# ansible-playbook --inventory-file=..//terraform-inventory/terraform-inventory ./ansible/playbook.yml -e @./ansible/vars.yml
#
# Run the playbooy (async)
ansible-playbook --inventory-file=..//terraform-inventory/terraform-inventory ./ansible/playbook-async.yml -e @./ansible/vars.yml
# director occasionally fails, moving to separate playbook for now
ansible-playbook --inventory-file=..//terraform-inventory/terraform-inventory ./ansible/dir.yml -e @./ansible/vars.yml
