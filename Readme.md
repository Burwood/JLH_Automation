# Getting Started with Automation

The goal of this project is to enable consultants who aren't focused on DevOps a quick path to leveraging automation tools in their projects.

Terraform will be used to provision resources.  Ansible will be used to install and configure software on those resources.  Pass will be used to securely store usernames, passwords, and other sensitive data.  

> Both Terraform and Ansible were chosen because they are agent-less and do not require a central management server to be deployed in the customer's environment.  Pass was chosen because it is super simple, can be quickly built and destroyed, and the secrets can be contained on the client's network if needed.

> Terraform is available for Windows, but Ansible and Pass are not.  I started working on a guide for using Terraform in Windows but the solutions for protecting usernames and passwords were either much more complex, poorly maintained, or had to be licensed.  It would also mean that the modularity of code snippets would be client OS restricted. Plus, Ansible is so much better at configuration management than Terraform that I decided to scrap the whole idea.  If you are new to Linux, feel free to reach out.  I would be happy to help as it can be a bit frustrating at first.


Useful links:\
Install WSL docs: https://docs.microsoft.com/en-us/windows/wsl/install-win10 \
Additional Linux distro downloads: https://docs.microsoft.com/en-us/windows/wsl/install-manual

# Install WSL (Windows Subsystem for Linux)
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all
```

## Update to WSL 2
Windows 10 v1903 or higher with Build 18362 or higher supports WSL 2, skip to **Install Ubuntu** if older
```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all
wget "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -outfile "wsl_update_x64.msi"
wsl_update_x64.msi
wsl --set-default-version 2
```

## Install Ubuntu
```powershell
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu2004.appx
```

## Launch Ubuntu
NOTE: If you are installing on a VM, make sure that Intel VT is enabled in the BIOS

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
Visual Studio Code: https://code.visualstudio.com/ **Highly Recommended!**\
Notepad++: https://notepad-plus-plus.org/downloads/ \
Sublime Text: https://www.sublimetext.com/


# Check out the [example project](https://github.com/Burwood/JLH_Automation/tree/master/Example_Project) for next steps!

---

