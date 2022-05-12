# Resource Group

## Nomenclatura

```
azu-rg-<subscription>-<sistema>

Sendo:
•	provedor: azu (Azure)
•	rg: resource group
•	subscription: tu, ti, th, pr (já configurado)
•	sistema: propósito do resource group

Exemplo:  azu-rg-tu-devops
```

# Como provisionar com terraform

## 1. Acessos necessários

* contributor na subscription onde irá criar o recurso Azure. Para criar lock e/ou associar com acr é necessário owner
* acesso de write nos storage accounts da subscription "Plataforma - DevOps" onde são armazenados os arquivos tfstate
  + Sustentação ao negócio
    - Storage account: azusadotrrfrm001
  + Negócio
    - Storage account: azusadotrrfrm002

## 2. Exemplo de recurso Azure provisionado com o módulo

[Projeto exemplo](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/rg-default)

## 3. Usar a versão latest do módulo

```
source = "git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-rg-default.git?ref=latest"
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

* [Arquivo backend.tf](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/backend.tf)

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

##  11. Avaliar o plano de execução do Terraform

```
terraform plan -var-file=env_variables/_${workspace_env}.tfvars
```

## 12. Executar o Terraform

```bash
terraform apply -var-file=env_variables/_${workspace_env}.tfvars
```

## 13. Destruir o recurso/stack criado

```
terraform destroy --var-file=${workspace_env}/_${workspace_env}.tfvars
```

# 14. Arquivos de variáveis

## Variável global

* [terraform.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/terraform.tfvars)

<span style="color:red">Não colocar acentos e/ou caracteres especiais nos textos das tags, pois devido a Azure não suportar caracteres especiais nas tags ocorrerá erro na criação do recurso</span>

## Variáveis de ambiente - env_variables/_env.tfvars

Informações dos ambientes de tu, ti, th e pr de acordo com a necessidade do recurso Azure
* [env_variables/_tu.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/env_variables/_tu.tfvars)
* [env_variables/_ti.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/env_variables/_ti.tfvars)
* [env_variables/_th.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/env_variables/_th.tfvars)
* [env_variables/_pr.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/env_variables/_pr.tfvars)
* [env_variables/_do.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/rg-default/env_variables/_do.tfvars)

### Ambiente

| Parâmetro   | Descrição 			                                            | Tipo	 | Exemplo    	      |
| ----------- | ----------------------------------------------------------- | ------ | ------------------ |
| environment | subscription onde o recurso será criado (incluído como tag) | string | tu, ti, th, pr, do |

| Subscription        | Parâmetro |
| ------------------- | --------- |
| OpenBanking - TU    | tu        |
| OpenBanking - TI    | ti        |
| OpenBanking - TH    | th        |
| OpenBanking - PRD   | pr        |
| Plataforma - DevOps | do        |

# 15. Documentação do módulo

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.97.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-tags-default.git | latest |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_lock.resource_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_key"></a> [backend\_key](#input\_backend\_key) | Nome do tf state file | `string` | `""` | no |
| <a name="input_backend_sa"></a> [backend\_sa](#input\_backend\_sa) | Backend do tf state file | `string` | `""` | no |
| <a name="input_centro_custo"></a> [centro\_custo](#input\_centro\_custo) | Centro de custo do recurso | `string` | `"opbk"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscription que o recurso será criado | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete"<br>]</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_repositorio"></a> [repositorio](#input\_repositorio) | Repositório do código da infraestrutura | `string` | `""` | no |
| <a name="input_rg_location"></a> [rg\_location](#input\_rg\_location) | Localização onde será criado o resource group | `string` | `"brazilsouth"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Nome do resource group | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_key"></a> [backend\_key](#output\_backend\_key) | Nome do tf state file |
| <a name="output_backend_sa"></a> [backend\_sa](#output\_backend\_sa) | Backend do tf state file |
| <a name="output_centro_custo"></a> [centro\_custo](#output\_centro\_custo) | Centro de custo do recurso |
| <a name="output_environment"></a> [environment](#output\_environment) | Subscrição onde o recurso será criado |
| <a name="output_lock_enabled"></a> [lock\_enabled](#output\_lock\_enabled) | Habilitar resource lock? |
| <a name="output_lock_level"></a> [lock\_level](#output\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) |
| <a name="output_objective"></a> [objective](#output\_objective) | Objetivo do sistema/recurso |
| <a name="output_owner"></a> [owner](#output\_owner) | Responsável pelo sistema/recurso |
| <a name="output_repositorio"></a> [repositorio](#output\_repositorio) | Repositório do código da infraestrutura |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | Objeto resource group |
| <a name="output_rg_location"></a> [rg\_location](#output\_rg\_location) | Localização onde será criado o resource group |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Nome do resource group |
| <a name="output_system"></a> [system](#output\_system) | Sistema |
| <a name="output_tags_custom"></a> [tags\_custom](#output\_tags\_custom) | Tags customizadas |
