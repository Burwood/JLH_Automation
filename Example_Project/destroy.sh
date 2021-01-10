#!/bin/bash
pass testuser > /dev/null
export TF_VAR_vsphere_user=$(pass vsphere_user)
export TF_VAR_vsphere_pass=$(pass vsphere_pass)                       
export TF_VAR_domain_user=$(pass domain_user)
export TF_VAR_domain_pass=$(pass domain_pass)
cd terraform
terraform destroy --var-file="values.tfvars"
