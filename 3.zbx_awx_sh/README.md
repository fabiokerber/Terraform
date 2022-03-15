
```
az version
az login
az group create -l brazilsouth -n rgazurecliwin
az group delete -n rgazurecliwin

terraform workspace new tu

terraform workspace list

terraform workspace select <workspace_name>

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

terraform plan -var-file="values.tfvars"
terraform apply -var-file="values.tfvars" -auto-approve
```
