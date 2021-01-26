#!/bin/bash

pass testuser > /dev/null
export TF_VAR_adminuser=$(pass adminuser)
export TF_VAR_adminpass=$(pass adminpass)
export TF_VAR_tenant_id=$(pass tenant_id)
export TF_VAR_subscription_id=$(pass subscription_id)
terraform init
terraform plan --var-file="azure.tfvars"
terraform apply --var-file="azure.tfvars"
