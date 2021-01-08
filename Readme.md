# Active Goals
- [ ] Learn Hashicorp Vault and create howto
- [ ] Create repo for Provisioning and Configuration Management
	- Providers
	- Service Catalog
	- Integrations
- [ ] Create Terraform guide and templates for vSphere and Azure
- [ ] Create Ansible pre-requisite guide and scripts



# Getting Started with Automation

The goal of this project is to enable consultants who aren't focused on DevOps a quick path to leveraging automation tools in thier projects.

Terraform will be used to provision resources, and Ansible will be used to install and configure software on those resources.  ~~Terraform is available for Windows, so if you only plan on automating provisioning, skip everything below, download Terraform from here: https://www.terraform.io/downloads.html and jump over to the [example project](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project).~~ Note: pass is used for secrets management in this project and is only available for Linux.  I will rewrite the example with HashiCorp Vault once I figure it out.

Useful links:\
Install WSL docs: https://docs.microsoft.com/en-us/windows/wsl/install-win10 \
Additional Linux distro downloads: https://docs.microsoft.com/en-us/windows/wsl/install-manual

# Install WSL (Windows Subsystem for Linux)
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
reboot
```

## Update to WSL 2
Windows 10 v1903 or higher with Build 18362 or higher supports WSL 2, skip to **Install Ubuntu** if older
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

# Install automation tools
let's do everything in our home directory
```bash
cd ~/
```

### Install Terraform
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
```

### Install Ansible
```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Install terraform-inventory
Terraform-inventory allows ansible to dynamically create inventory from a terraform state file

```bash
mkdir ~/terraform-inventory && cd terraform-inventory/
curl -fsSL -o terraform-inventory_0.9_linux_amd64.zip https://github.com/adammck/terraform-inventory/releases/download/v0.9/terraform-inventory_0.9_linux_amd64.zip && unzip terraform-inventory_0.9_linux_amd64.zip
rm terraform-inventory_0.9_linux_amd64.zip
```

### Install pass and gpg
```bash
sudo apt install pass gnupg2
```

Create a GPG key
```bash
gpg2 --gen-key
```

You will see output similar to the following.  Make sure to save the 20byte hex key.

	gpg: key <8byte-hex> marked as ultimately trusted
	gpg: directory '/home/jheistand/.gnupg/openpgp-revocs.d' created
	gpg: revocation certificate stored as '/home/jheistand/.gnupg/openpgp-revocs.d/<20byte-hex>.rev'
	public and secret key created and signed.
	pub   rsa3072 2020-12-14 [SC] [expires: 2022-12-14]
		  <20byte-hex>
	uid                      James Heistand <jheistand@burwood.com>
	sub   rsa3072 2020-12-14 [E] [expires: 2022-12-14]

Add your GPG key to your bash profile for programs to autmatically use it

```bash
echo "export GPGKEY=<last 4hex bytes>" >> ~/.profile
```

Setup pass, a simple CLI based password vault.  

```bash
pass init "<last 4hex bytes>"
```

### Install an editor (optional)
Visual Studio Code: https://code.visualstudio.com/ \
Notepad++: https://notepad-plus-plus.org/downloads/ \
Sublime Text: https://www.sublimetext.com/


# Check out the [example project](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project) for next steps!

---

