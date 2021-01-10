#!/bin/bash
# Create builddoc stub
echo '## VM Inventory' >> builddoc.md

# open the password database with a dummy secret, export secrets to variables for terraform, export terraform state
pass testuser > /dev/null
export TF_VAR_vsphere_user=$(pass vsphere_user)
export TF_VAR_vsphere_pass=$(pass vsphere_pass)                       
export TF_VAR_domain_user=$(pass domain_user)
export TF_VAR_domain_pass=$(pass domain_pass)
export TF_STATE=./terraform

# change to the terraform directory, initialize, and run the build 
cd terraform
terraform init
# terraform plan --var-file="lab.tfvars"
terraform apply --var-file="values.tfvars"
cat tf_doc.md >> ../builddoc.md
cd ..
