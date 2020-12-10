#!/bin/bash
cd terraform
terraform destroy --var-file="lab.tfvars"
