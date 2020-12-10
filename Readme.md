# Getting Started with Automation

The goal of this project is to enable consultants who aren't focused on DevOps a quick path to leveraging automation tools in thier projects.

Terraform will be used to provision resources, and Ansible will be used to install and configure software on those resources.  Terraform is available for Windows, so if you only plan on automating provisioning, skip everything below, download Terraform from here: https://www.terraform.io/downloads.html and jump over to the [example project](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project).

Useful links:\
Install WSL docs: https://docs.microsoft.com/en-us/windows/wsl/install-win10 \
Additional Linux distro downloads: https://docs.microsoft.com/en-us/windows/wsl/install-manual

## Install WSL (Windows Subsystem for Linux)
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
reboot
```

## Update to WSL 2
Windows 10 v1903 or higher with Build 18362 or higher supports WSL 2, skip to **Install Ubuntu** if older\
```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
reboot
$url = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
wsl_update_x64.msi
wsl --set-default-version 2
```

## Install Ubuntu
```powershell
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing`
Add-AppxPackage .\Ubuntu2004.appx
```

## Launch Ubuntu
Create a user account and set the password

## Install automation tools
let's do everything in our home directory\
```bash
cd ~/
```

## Install Terraform
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
```

## Install Ansible
```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Install terraform-inventory
Terraform-inventory allows ansible to dynamically create inventory from a terraform state file

```bash
mkdir ~/terraform-inventory && cd terraform-inventory/
curl -fsSL -o terraform-inventory_0.9_linux_amd64.zip https://github.com/adammck/terraform-inventory/releases/download/v0.9/terraform-inventory_0.9_linux_amd64.zip && unzip terraform-inventory_0.9_linux_amd64.zip
rm terraform-inventory_0.9_linux_amd64.zip
```

## Install an editor (optional)
Visual Studio Code: https://code.visualstudio.com/ \
Notepad++: https://notepad-plus-plus.org/downloads/ \
Sublime Text: https://www.sublimetext.com/


# Check out the [example project](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project) for next steps!

---

#### Project Development Goals
- Package the local workstation install steps into a Windows script and a Linux script
- Break down example project with comments
- Review other Burwood repos and reuse code for GCP and Azure deployments
- Work with other teams to create templates for other technologies in the professional services product catalog
- Move secrets to a secure solution
  - pass
  - Hashicorp Vault
