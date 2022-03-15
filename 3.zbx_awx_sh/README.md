
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
```

Criando o *resource group*.<br>
```
az group create -l brazilsouth -n rg-br-tu-awx-redhat
```

Criando *Storage Account* via CLI.<br>
```
az storage account create --name tfstateawx --resource-group rg-br-tu-awx-redhat --location brazilsouth --sku Standard_LRS
```

Criando *Container* via CLI.<br>
```
az storage container create --name tfstateawx-files --account-name tfstateawx
```

Execute o comando abaixo e anote os dados da *key1*.<br>
```
az storage account keys list --account-name tfstateawx --resource-group rg-br-tu-awx-redhat 
```

Adicione a *key1* à chave *key* em *backend.tf*.<br>
<br>
É indicado no backend.tf aonde será armazenado o tfstate.<br>
Blob Storage > Container > Files<br>
O acesso ao Blob Storage é feito via key.<br>
tfstate armazenado no Azure em Blob Storage, é possível "lockar" enquanto utitiliza.<br>
<br>

Criar Virtual Network.<br>
```
az network vnet create --name tu-vnet --resource-group rg-br-tu-awx-redhat --subnet-name AwxSubnet
```

Criar Security Group.<br>
```
az network nsg create -g rg-br-tu-awx-redhat -n sg-vm-linux-redhat
```

Criar Rule.<br>
Obs: Melhorar segurança portas.<br>
```
az network nsg rule create -g rg-br-tu-awx-redhat --nsg-name sg-vm-linux-redhat -n AllowInboundTo80 --priority 100 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 80 --access Allow --direction Inbound --protocol Tcp --description "Allow * to 80/tcp."
```

Provisionar ambiente.<br>
```
terraform plan -var-file="values.tfvars"
terraform apply -var-file="values.tfvars" -auto-approve
```

Obs: Interessante criar:<br>
1. Resource Group
2. Storage Account
3. Container
4. backend.tf with *SA-key*

