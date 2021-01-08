#!/bin/bash
# open the password database with a dummy secret
pass testuser > /dev/null
# export secrets to variables for terraform
export TF_VAR_cvad_lab_vsphere_user=$(pass cvad_lab_vsphere_user)
export TF_VAR_cvad_lab_vsphere_pass=$(pass cvad_lab_vsphere_pass)                       
export TF_VAR_cvad_lab_domain_user=$(pass cvad_lab_domain_user)
export TF_VAR_cvad_lab_domain_pass=$(pass cvad_lab_domain_pass)
cd terraform
terraform destroy --var-file="lab.tfvars"
