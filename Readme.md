# Getting Started with Automation

Terraform will be used to provision resources, and Ansible will be used to install and configure software on those resources.

    Useful links
    Install WSL docs: https://docs.microsoft.com/en-us/windows/wsl/install-win10
    Additional Linux distro downloads: https://docs.microsoft.com/en-us/windows/wsl/install-manual

## Install WSL
*Powershell*\
`dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`\
`reboot`

## Update to WSL 2
Windows 10 v1903 or higher with Build 18362 or higher supports WSL 2, skip to **Install Ubuntu** if older\
*Powershell*\
`dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`\
`reboot`\
`$url = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"`\
`(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)`\
`wsl_update_x64.msi`\
`wsl --set-default-version 2`

## Install Ubuntu
*Powershell*\
`Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu2004.appx -UseBasicParsing`\
`Add-AppxPackage .\Ubuntu2004.appx`



## Launch Ubuntu
Create a user account and set the password

## Install automation tools
let's do everything in our home directory\
*#!/bin/bash*\
`cd ~/`

## Install Terraform
*#!/bin/bash*\
`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`\
`sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`\
`sudo apt install terraform`

## Install Ansible
*#!/bin/bash*\
`sudo apt update`\
`sudo apt install software-properties-common`\
`sudo apt-add-repository --yes --update ppa:ansible/ansible`\
`sudo apt install ansible`

## Install terraform-inventory
Terraform-inventory allows ansible to dynamically create inventory from a terraform state file

*#!/bin/bash*\
`mkdir ~/terraform-inventory && cd terraform-inventory/`\
`curl -fsSL -o terraform-inventory_0.9_linux_amd64.zip https://github.com/adammck/terraform-inventory/releases/download/v0.9/terraform-inventory_0.9_linux_amd64.zip && unzip terraform-inventory_0.9_linux_amd64.zip`\
`rm terraform-inventory_0.9_linux_amd64.zip`

---
# Configure the template VM

## Install chocolatey
*Powershell*\
`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

## Configure WinRM
*Powershell*\
`$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"`\
`$file = "$env:temp\ConfigureRemotingForAnsible.ps1"`\
`(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)`\
`powershell.exe -ExecutionPolicy ByPass -File $file`

# Check out the example project for next steps!
