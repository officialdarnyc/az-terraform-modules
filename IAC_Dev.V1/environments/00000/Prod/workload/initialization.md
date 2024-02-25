<!-- Prerequisites before running the scripts -->
# Install below mentioned tools on the machine, where you will be running the scripts
# 1. AzureCLI
# 2. Terraform
# 3. Kubectl

# User will need below mentioned rights 
#    1. subscription owner access
#    2. AAD read/write permissions to run the scripts.

<!-- Steps to run the scripts -->
# az login - Login to azure portal
# az account set -s <subscription_id>
# terraform init
# terraform plan -var-file=<config_file_path> -out=<plan_file_name>
# terraform apply <plan_file_name>
# az aks check-acr --name <cluster_name> --resource-group <resource_group_name> --acr <acr_name>
# az aks update -n <cluster_name> -g <resource_group_name> --attach-acr <acr-name>

az login
az account set -s "7ba9507c-1407-4e95-9df8-5b84f40c1a0d"
terraform init
terraform validate
terraform plan -var-file=environment.config -out=main.plan
terraform apply main.plan
#az aks update -n xcc-001000-test-aks -g xcc-001000-test-rg --attach-acr acrxccpoceus01
