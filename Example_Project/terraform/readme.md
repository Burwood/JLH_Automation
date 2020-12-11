### This is the working terraform directory
Take a look at the files contained within and review the comments to understand the syntax

**main.tf** \
This file contains information on what to conenct to (the provider) where it should go (the data types) and what it should build or update (the resource blocks)

**variables.tf** \
This file defines the variables we will use in other .tf files to keep everything modular and portable

**lab.tfvars** \
This file assigns project specific values to the variables.  What is the name of the vCenter server?  What credentials should we use to connect?

