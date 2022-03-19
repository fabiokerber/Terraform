# ZBX_AWX_SH RHEL 7.8

Criando o *Resource Group* para armazenamento das keys via CLI.<br>
```
az group create -l brazilsouth -n rg-ssh-keys-br-sh
```

Criar par de chaves Azure.<br>
```
https://docs.microsoft.com/pt-br/azure/virtual-machines/ssh-keys-portal

Create an SSH key (Resource SSH keys)
Resource group: rg-ssh-keys-br-sh
Key pair name: key-vm-ssh-br-sh
```

Criando o *Resource Group* via CLI.<br>
```
az group create -l brazilsouth -n rg-br-tfstate
```

Criando *Storage Account* via CLI.<br>
```
az storage account create --name tfstatesh --resource-group rg-br-tfstate --location brazilsouth --sku Standard_LRS
```

Criando *Container* via CLI.<br>
```
az storage container create --name tfstatesh-files --account-name tfstatesh
```

Coletar os dados da *key1* via CLI..<br>
```
az storage account keys list --account-name tfstatesh --resource-group rg-br-tfstate
```

Adicione a *key1* à chave *key* em *backend.tf*.<br>
<br>
É indicado no backend.tf aonde será armazenado o tfstate.<br>
Blob Storage > Container > Files<br>
O acesso ao Blob Storage é feito via key.<br>
tfstate armazenado no Azure em Blob Storage, é possível "lockar" enquanto utitiliza.<br>
<br>

Provisionar ambiente.<br>
```
terraform init
terraform workspace new hml
terraform workspace new prd
terraform workspace list
terraform workspace select hml
terraform fmt
terraform validate
terraform plan -var-file="values.tfvars"
terraform apply -var-file="values.tfvars" -auto-approve
```

Acessar o AWX.<br>
admin<br>
123@mudar<br>
```
http://vmawxbrsh.brazilsouth.cloudapp.azure.com/
```

Conectar na VM (Git Bash).<br>
```
cp ssh-key/key-vm-ssh-br-sh.pem ~/.ssh/
chmod 400 ~/.ssh/key-vm-ssh-br-sh.pem
ssh -i ~/.ssh/key-vm-ssh-br-sh.pem <vm_admin_username>@<public_ip_address>
Ex: ssh -i ~/.ssh/key-vm-ssh-br-sh.pem kerberos@20.226.6.113
```

Criando gráfico dos recursos existentes no Azure
```
terraform graph | dot -Tsvg
```

Obs: 
1. Necessário instalar o graphviz localmente (https://graphviz.org/download/).
2. Navegar até a pasta do projeto


# Backup.<br>

Gerenciar a VM.<br>
```
az vm start --resource-group rg-vm-awx-br-sh --name vm-awx-br-sh
az vm stop --resource-group rg-vm-awx-br-sh --name vm-awx-br-sh
```

Criar/Editar Virtual Network.<br>
```
az network vnet create --name tu-vnet --resource-group rg-br-tu-awx-redhat --subnet-name AwxSubnet
az network vnet create --name tu-vnet --resource-group rg-br-tu-awx-redhat --address-prefixes 10.0.0.0/16
az network vnet subnet update --name tu-vnet --vnet-name tu-vnet --resource-group rg-br-tu-awx-redhat --address-prefixes 192.168.0.0/16
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

```
output "resource-group_full" {
  value       = azurerm_resource_group.resource-group
  description = "Resource Group"
}
```

Comandos de auxílio.<br>
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
terraform init -reconfigure
terraform init -migrate-state
az vm image list --output table
az vm image list --offer CentOS --all --output table
az vm image list --location brazilsouth --publisher Canonical --offer UbuntuServer --all --output table
az vm image list --location brazilsouth --publisher RedHat --offer RHEL --all --output table
```

Firewall
```
sudo firewall-cmd --zone=public --add-port=6443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8472/udp --permanent
sudo firewall-cmd --zone=public --add-port=10250/tcp --permanent
sudo firewall-cmd --zone=public --add-port=2379-2380/tcp --permanent
sudo firewall-cmd --reload
```