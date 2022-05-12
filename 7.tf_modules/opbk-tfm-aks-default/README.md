# Azure Kubernetes Services

## Nomenclatura

```
azu-aks-<subscription>-<nome>-<contador>

Sendo:
• azu: azu: Azure cloud
•	aks: Azure Kubernetes
•	subscription: tu, ti, th, pr
•	nome: nome do aks (8 caracteres)
•	contador: contador de 001-999

Exemplo:  azu-aks-tu-int-001
```

# Como provisionar com terraform

## 1. Acessos necessários

* contributor na subscription onde irá criar o recurso Azure. Para criar lock do recurso é necessário owner
* acesso de write nos storage accounts da subscription "Plataforma - DevOps" onde são armazenados os arquivos tfstate
  + Sustentação ao negócio
    - Storage account: azusadotrrfrm001
  + Negócio
    - Storage account: azusadotrrfrm002
* subscription "OpenBanking - SharedServices", resource group: "pvtend-vnet"
    - Network Contributor
    - Private DNS Zone Contributor
* subscription "DITI-IDENTITY", resource group: "pvtzone-rg"
  + Reader
  + Private DNS Zone Contributor

## 2. Exemplo de recurso Azure provisionado com o módulo

[Projeto exemplo](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default)
* Sugestão: fazer um fork do repositório

## 3. Usar a versão desejada do módulo

[Arquivo main.tf do módulo root](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/main.tf)

```
source = "git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-aks-default.git?ref=latest"
```

## 4. Configurar os parâmetros necessários

* Seguir documentação do módulo

## 5. Arquivos tfstate do Terraform

### Os arquivos tfstate são responsáveis por armazenar o estado da infraestrutura provisionada pelo Terraform. No Bradesco os tfstate files estão organizados conforme abaixo:

* Sustentação ao negócio
  + Subscription: Plataforma - DevOps
  + Storage account: azusadotrrfrm001
  + Container: tfstate-sustentacao
* Negócio
  + Subscription: Plataforma - DevOps
  + Storage account: azusadotrrfrm002
  + Container: tfstate-negocio

* Nota: definir apenas um storage account/container para o arquivo tfstate

### Configurar o backend do módulo root (módulo que importa o módulo terraform) para o tfstate ser armazenado no storage account correto

* [Arquivo backend.tf](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/backend.tf)

## 6. Login na Azure - a stack/recursos será provisionado na subscription do login 

```bash
az login -u <user>@bradesco.com.br -o table
az account set -s "<nome_subscription>"
az account show -o table
```

## 7. Inicializar o Terraform

```bash
terraform init
```

## 8. Criar os workspaces (espaços de trabalho onde separaram as configurações da stack/recurso de cada subscription)

```bash
terraform workspace new {tu|ti|th|pr|do}
```

## 9. Selecionar o workspace (ambiente) do recurso

```bash
terraform workspace list
terraform workspace select <workspace_name>
```

## 10. Definir a variável correspondente ao ambiente

```bash
workspace_env="{tu|ti|th|pr}"
```

##  11. Avaliar e criar o plano de execução do Terraform

```bash
terraform plan -var-file=env_variables/_${workspace_env}.tfvars -out aks.tfplan
```

## 12. Executar plano Terraform

```bash
terraform apply aks.tfplan
```

## 13. Avaliar e criar o plano de destruição do Terraform

```bash
terraform plan -destroy --var-file=env_variables/_${workspace_env}.tfvars -out aks.destroy.tfplan
```

## 13.1 Executar plano de destruição do recurso/stack criado

```bash
terraform apply aks.destroy.tfplan
```

# 14. Arquivos de variáveis

## Variável global

* [terraform.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/terraform.tfvars)

<span style="color:red">Não colocar acentos e/ou caracteres especiais nos textos das tags, pois devido a Azure não suportar caracteres especiais nas tags ocorrerá erro na criação do recurso</span>

## Variáveis de ambiente - env_variables/_env.tfvars

Informações dos ambientes de tu, ti, th e pr de acordo com a necessidade do recurso Azure
* [env_variables/_tu.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/env_variables/_tu.tfvars)
* [env_variables/_ti.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/env_variables/_ti.tfvars)
* [env_variables/_th.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/env_variables/_th.tfvars)
* [env_variables/_pr.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/env_variables/_pr.tfvars)
* [env_variables/_do.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/aks/aks-default/env_variables/_do.tfvars)

## Ambiente

| Input       | Descrição 			                                            | Tipo	 | Exemplo         	  |
| ----------- | ----------------------------------------------------------- | ------ | ------------------ |
| environment | subscription onde o recurso será criado (incluído como tag) | string | tu, ti, th, pr, do |

| Subscription        | Input     |
| ------------------- | --------- |
| OpenBanking - TU    | tu        |
| OpenBanking - TI    | ti        |
| OpenBanking - TH    | th        |
| OpenBanking - PRD   | pr        |
| Plataforma - DevOps | do        |

# 15. Documentação do módulo

