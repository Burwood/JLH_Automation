#!/bin/bash
# Copy doc stub to project folder
mkdir -p docs/
cp ~/docs/top.md ./docs/

# open the password database with a dummy secret, export secrets to variables for terraform, export terraform state
pass testuser > /dev/null
export TF_VAR_cvad_lab_vsphere_user=$(pass cvad_lab_vsphere_user)
export TF_VAR_cvad_lab_vsphere_pass=$(pass cvad_lab_vsphere_pass)
export TF_VAR_cvad_lab_domain_user=$(pass cvad_lab_domain_user)
export TF_VAR_cvad_lab_domain_pass=$(pass cvad_lab_domain_pass)
export TF_STATE=./terraform

# change to the terraform directory, initialize, and run the build 
cd terraform
terraform init
# terraform plan --var-file="lab.tfvars"
terraform apply --auto-approve --var-file="lab.tfvars"

# terraform docs
mv tf_info.md ../docs/
cd ../docs
cat tf_info.md >> top.md

# pause, then start ansible config
cd ..
sleep 60s
# terraform-inventory expects TF_STATE to be set
TF_STATE=./terraform/
# run ansible playbook, Citrix Director errors out, running as separate job, run doc script, export verbose ansible info
ansible-playbook --inventory-file=/home/jheistand/tf-inv/terraform-inventory ./ansible/playbook-async.yml -e @./ansible/vars.yml
ansible-playbook --inventory-file=/home/jheistand/tf-inv/terraform-inventory ./ansible/dir.yml -e @./ansible/vars.yml
ansible-playbook --inventory-file=/home/jheistand/tf-inv/terraform-inventory ./ansible/docs.yml -e @./ansible/vars.yml


# ansible docs
cd docs
unzip docs.zip
# Couple quick fixes to the output of Carl's script
# Not sure why the html file is created in UCS-2LE encoding
iconv -f UCS-2LE -t UTF-8 MyTestSite.html -o MyTestSite.htm
# perl regex replace to update the default colors
perl -i -p -e 's/C0C0C0/111111/' MyTestSite.htm
perl -i -p -e 's/FFFFFF/333333/' MyTestSite.htm
cat MyTestSite.htm >> top.md

### Disabled items ###

### The Terraform and Ansible inventory ouputs are very verbose.  Not sure if it is worth parsing to make readable.
# terraform show -no-color > ../docs/terraform_show.md
# perl regex replace to add newline after { for formatting
#perl -i -p -e 's/{\n/{\r\n\n/' terraform_show.md
# cat terraform_show.md >> top.md
# ansible-inventory --inventory-file=/home/jheistand/tf-inv/terraform-inventory --list --output ./docs/ansible_facts.yml