
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

tfstate armazenado no Azure em Blob Storage, é possível "lockar"<br>

Criando *Storage Account* via CLI
```
az storage account create --name tfstateawx --resource-group rg-br-tu-awx-redhat --location brazilsouth --sku Standard_LRS
```

Criando *Container* via CLI
```
az storage container create --name tfstateawx-files --account-name tfstateawx
```

Dentro da Storage account, acesse *Access keys*, clique em *Show keys* e anote os dados da *key1*.<br>
<br>
Adicione a *Key* da *key1* à chave *key* em *backend.tf*.<br>
<br>
É indicado no backend.tf aonde será armazenado o tfstate.<br>
Blob Storage > Container > Files<br>
O acesso ao Blob Storage é feito via key.<br>

