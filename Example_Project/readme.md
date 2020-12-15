# Project Description
This example project will create a SQL server. \
Terraform is used to provision the VM to on-prem vSphere, rename it, and join it to the domain. \
Ansible is used to install software packages.

## Inventory
- 1 SQL Server

## Build.sh breakdown
`terraform init` - Terraform reads all the .tf files to identify needed plugins and modules and downloads them to the current project directory.

`terraform plan --var-file="<variable file>"` - Terraform outputs what it is going to do based on all the project files, but doesn't execute the project. `-out=path` will save the output to a file.

`terraform apply --var-file="<variable file>"` - Terraform will execute the plan. Insert `--auto-approve' if you do not want to be prompted for confirmation.

 **NOTE - If you are just using Terraform, delete or comment out everything after the `terraform apply` command.**

`sleep 60s` - Pause before executing the Ansible playbook.

`TF_STATE=./terraform/` - Terraform-inventory will parse the Terraform state and parse it so Ansible can read it as an Ansible inventory.

`ansible-playbook --inventory-file=../terraform-inventory/terraform-inventory ./ansible/playbook-async.yml -e @./ansible/vars.yml` - Run the Ansible playbook, referencing the inventory file and the variable file.

## Destroy.sh breakdown
`terraform destroy --var-file="<variable file>"` - Terraform destroys everything in the plan.  This is equivalent to powering off the VMs, deleting them from disk in vSphere, and deleting the VM folder.  A future version should run an Ansible playbook to clean up AD accounts.
 
---

# Take a look at the [Terraform](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project/terraform) and [Ansible](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project/ansible) directories to learn more about each

---

# Next steps

## Configure a template VM

**Note** This project expects there to be one snapshot on the template VM so we can leverage linked-clones

### Install chocolatey
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### Configure WinRM
```powershell
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file
``` 

### Populate secrets in pass
We will create all our project secrets and a dummy secret "testuser".  Avoid "-" in the secret name, as Ansible doesn't like that character in a variable. The first time you query the pass database, it will prompt you for your master password.  We will use the testuser secret to query the pass database before running the scripts.

Run these one at a time, as each will prompt for the value of that secret.  

```bash
pass insert testuser
pass insert vsphere_user
pass insert vsphere_pass                       
pass insert domain_user
pass insert domain_pass
pass insert ansible_user
pass insert ansible_pass
pass insert sql_user
pass insert sql_pass
```

### Copy the repo locally
I have some work to do to allow git clone to work.  For now, click on "<> Code" on the top left, and then the green "Code" dropdown button and select "Download ZIP", I'll assume you saved it in C:\Users\Username\Downloads

```bash
unzip /mnt/c/Users/jheistand/Downloads/JLH_Automation-master.zip "JLH_Automation-master/Example_Project/*" -d ~/

```

### Update the variable files to match your environment
```bash
nano ~/JLH_Automation-master/Example_Project/Ansible/vars.yml
nano ~/JLH_Automation-master/Example_Project/Terraform/lab.tfvars
```

### Run the build.sh script
```bash
cd ~/JLH_Automation-master/Example_Project/
pass testuser
./build.sh
```

---

## References
https://www.terraform.io/docs/commands \
https://github.com/adammck/terraform-inventory \
https://github.com/ryancbutler/Citrix-VAD-LAB (The source I stole everything from!)
