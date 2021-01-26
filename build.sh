#!/bin/bash

pass testuser > /dev/null
export TF_VAR_adminuser=$(pass adminuser)
export TF_VAR_adminpass=$(pass adminpass)
terraform init
terraform plan --var-file="azure.tfvars"
terraform apply --var-file="azure.tfvars"
