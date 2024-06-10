# F5OS Terraform automation example


This repo contains a basic terraform recipe as an example how to provision F5OS appliances.

What it does:  

- connects to single F5OS appliance specified in credentials.auto.tfvars
- creates a VLAN objects specified in vlans.auto.tfvars
- creates two LAG interfaces and assings corresponding VLANs (LAG - internal VLANs, LAG - external VLANs)
- spins up a BIG-IP tenant, assigns system resources and VLANs


## Before you start
* clone the repo
* add username and password  to credentials.auto.tfvars or deliver it as an ENVVARs
* add F5OS appliance IP or FQDN to credentials.auto.tfvars

## Use the recipe

```
terraform init
terraform plan
./apply
```