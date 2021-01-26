# Azure Terraform Template
This is a template for provisioning VMs in Azure.  \
Provisioning a Ubuntu 18.04 VM in the Burwood Azure tenant ad.lakesidehealthsystems.com has been tested.

## Prerequisites
Install Azure CLI found here: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

Login to Azure CLI
```bash
az login
```

For other clients, get the tenant ID and subscription ID and populate in pass
```bash
az account list
```

## Secrets to populate in pass
- tenant_id
- subscription_id
- adminuser
- adminpass
