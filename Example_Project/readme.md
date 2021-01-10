# Project Description
This example project will use Terraform to provision the VM to on-prem vSphere, rename it, and join it to the domain.


## Inventory
- 1 VM named sql01

## Build.sh breakdown
Script process flow
- Create a document stub that we will append to as things are created
- Query the pass database.  You will be prompted for the master password and the database will remain open for 10min
- Store usernames and passwords needed for this Terraform project into memory resident variables
- `terraform init` - Terraform reads all the .tf files to identify needed plugins and modules and downloads them to the current project directory.
- `terraform plan --var-file="<variable file>"` - Terraform outputs what it is going to do based on all the project files, but doesn't execute the project. `-out=path` will save the output to a file.
- `terraform apply --var-file="<variable file>"` - Terraform will execute the plan. Insert `--auto-approve` if you do not want to be prompted for confirmation.


## Destroy.sh breakdown
Script process flow
- Query the pass database.  You will be prompted for the master password and the database will remain open for 10min
- Store usernames and passwords needed for this Terraform project into memory resident variables
- `terraform destroy --var-file="<variable file>"` - Terraform destroys everything in the plan.  This is equivalent to powering off the VMs, deleting them from disk in vSphere, and deleting the VM folder.  A future version should run an Ansible playbook to clean up AD accounts.
 
---
#### Take a look at the files in the [Terraform](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project/terraform) directory to learn more.  Each has comments to help you understand what is going on.
---

# Next steps

## Configure a template VM
Create a Windows Server 2019 VM and install VMware tools if needed

### Configure WinRM for future projects with Ansible
```powershell
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file
``` 

### Create a VM snapshot
This project expects there to be one snapshot on the template VM so we can leverage linked-clones

## Populate secrets in pass
We will create all our project secrets and a dummy secret "testuser".  Avoid "-" in the secret name, as Ansible doesn't like that character in a variable. The first time you query the pass database, it will prompt you for your master password.  We will use the testuser secret to query the pass database before running the scripts.

Run these one at a time, as each will prompt for the value of that secret. 

```bash
pass insert testuser
pass insert vsphere_user
pass insert vsphere_pass                       
pass insert domain_user
pass insert domain_pass
```

## Copy the repo locally
I have some work to do to allow git clone to work for a subset of the repo.  While this totally goes against the spirit of what we are trying to accomplish, for now we will download each file manually.  Github doesn't seem to support storing .zip or .tar files. :(


Right click on each of the following files > Save link as... > Save it to your Downloads folder. Don't worry about folder structure when downloading.

    build.sh
    destroy.sh
    terraform\main.tf
    terraform\values.tfvars
    terraform\variables.tf

If we create new files in Ubuntu from Windows, Ubuntu doesn't see them properly.  So we will copy from Ubuntu.  Note, once a file exists in Ubuntu, you can edit it within Windows! You can access the Ubuntu file structure from a path similar to this: 

`C:\Users\jheistand\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\rootfs\`


Open the Ubuntu console

```bash
mkdir Example_Project
mkdir Example_Project/terraform
cp /mnt/c/Users/<your username>/Downloads/build.sh ~/Example_Project/
cp /mnt/c/Users/<your username>/Downloads/destroy.sh ~/Example_Project/
cp /mnt/c/Users/<your username>/Downloads/main.tf ~/Example_Project/terraform/
cp /mnt/c/Users/<your username>/Downloads/values.tfvars ~/Example_Project/terraform/
cp /mnt/c/Users/<your username>/Downloads/variables.tf ~/Example_Project/terraform/
```

### Update the variable files to match your environment
You can do this in Windows using one of the editors recommended on the top-level page, or via a Linux text editor such as nano, vi, or emacs.
```bash
nano ~/Example_Project/Terraform/values.tfvars
```

### Run the build.sh script
```bash
cd ~/Example_Project/
./build.sh
```

---

## References I used to create this project
https://www.terraform.io/docs/commands \
https://github.com/adammck/terraform-inventory \
https://github.com/ryancbutler/Citrix-VAD-LAB \
https://www.passwordstore.org/ \
https://git.zx2c4.com/password-store/about/

