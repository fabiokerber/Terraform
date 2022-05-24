# Azure Container Registry

## Nomenclatura

```
Nomenclatura

azuacr<subscription><nome>001

Sendo:
•	azu: Azure cloud
•	acr: Azure Container Registry
•	subscription: tu, ti, th, pr
•	nome: mnemonico do nome do recurso (até 8 caracteres)
•	contador: contador de 001-999

Exemplo:  azuacrprdevops001
```

# Como provisionar com terraform

## 1. Acessos necessários

* contributor na subscription onde irá criar o recurso Azure. Para criar lock e/ou associar com acr é necessário owner
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

[Projeto exemplo](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default)

## 3. Usar a versão desejada do módulo

[Arquivo main.tf do módulo root](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/main.tf)

```
source = "git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-acr-default.git?ref=latest"
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

* [Arquivo backend.tf](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/backend.tf)

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
terraform plan -var-file=env_variables/_${workspace_env}.tfvars -out acr.tfplan
```

## 12. Executar plano Terraform

```bash
terraform apply acr.tfplan
```

## 13. Avaliar e criar o plano de destruição do Terraform

```bash
terraform plan -destroy --var-file=env_variables/_${workspace_env}.tfvars -out acr.destroy.tfplan
```

## 13.1 Executar plano de destruição do recurso/stack criado

```bash
terraform apply acr.destroy.tfplan
```

# 14. Arquivos de variáveis

## Variável global

* [terraform.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/terraform.tfvars)

<span style="color:red">Não colocar acentos e/ou caracteres especiais nos textos das tags, pois devido a Azure não suportar caracteres especiais nas tags ocorrerá erro na criação do recurso</span>

## Variáveis de ambiente - env_variables/_env.tfvars

Informações dos ambientes de tu, ti, th e pr de acordo com a necessidade do recurso Azure
* [env_variables/_tu.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/env_variables/_tu.tfvars)
* [env_variables/_ti.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/env_variables/_ti.tfvars)
* [env_variables/_th.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/env_variables/_th.tfvars)
* [env_variables/_pr.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/env_variables/_pr.tfvars)
* [env_variables/_do.tfvars](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-example/browse/acr-default/env_variables/_do.tfvars)

## Ambiente

| Input       | Descrição 			                                            | Tipo	 | Exemplo         	  |
| ----------- | ----------------------------------------------------------- | ------ | ------------------ |
| environment | subscription onde o recurso será criado (incluído como tag) | string | tu, ti, th, pr, do |

| Subscription        | Input |
| ------------------- | ----- |
| OpenBanking - TU    | tu    |
| OpenBanking - TI    | ti    |
| OpenBanking - TH    | th    |
| OpenBanking - PRD   | pr    |
| Plataforma - DevOps | do    |

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
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-pvtend-default.git | latest |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-tags-default.git | latest |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_management_lock.resource_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.diasettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | acr\_admin\_enabled | `bool` | `false` | no |
| <a name="input_acr_location"></a> [acr\_location](#input\_acr\_location) | Localização da Azure Container Registry | `string` | `"brazilsouth"` | no |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Nome do Azure Container Registry | `string` | n/a | yes |
| <a name="input_acr_rg_name"></a> [acr\_rg\_name](#input\_acr\_rg\_name) | Resource group do Azure Container Registry | `string` | n/a | yes |
| <a name="input_acr_sku_name"></a> [acr\_sku\_name](#input\_acr\_sku\_name) | Sku do Azure Container Registry | `string` | `"Premium"` | no |
| <a name="input_backend_key"></a> [backend\_key](#input\_backend\_key) | Nome do tf state file | `string` | `""` | no |
| <a name="input_backend_sa"></a> [backend\_sa](#input\_backend\_sa) | Backend do tf state file | `string` | `""` | no |
| <a name="input_centro_custo"></a> [centro\_custo](#input\_centro\_custo) | Centro de custo do recurso | `string` | `"opbk"` | no |
| <a name="input_contador"></a> [contador](#input\_contador) | Contador do recurso | `number` | `1` | no |
| <a name="input_diagsettings_enabled"></a> [diagsettings\_enabled](#input\_diagsettings\_enabled) | Diagnostic settings habilitado? | `bool` | `false` | no |
| <a name="input_diagsettings_logs_category"></a> [diagsettings\_logs\_category](#input\_diagsettings\_logs\_category) | Categoria de logs do diagnostic settings | `map(any)` | <pre>{<br>  "ContainerRegistryLoginEvents": true,<br>  "ContainerRegistryRepositoryEvents": true<br>}</pre> | no |
| <a name="input_diagsettings_metric_category"></a> [diagsettings\_metric\_category](#input\_diagsettings\_metric\_category) | Categoria de métricas do diagnostic settings | `map(any)` | <pre>{<br>  "AllMetrics": true<br>}</pre> | no |
| <a name="input_diagsettings_retention_days"></a> [diagsettings\_retention\_days](#input\_diagsettings\_retention\_days) | Nro dias retenção Diagnostic settings | `number` | `30` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscription que o recurso será criado | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete"<br>]</pre> | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | Log analytics workspace | <pre>map(object({<br>    workspace_name    = string<br>    workspace_rg_name = string<br>  }))</pre> | <pre>{<br>  "do": {<br>    "workspace_name": "azu-log-do-pltfrma-001",<br>    "workspace_rg_name": "azu-rg-do-pltfrma"<br>  },<br>  "pr": {<br>    "workspace_name": "la-br-pr-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "th": {<br>    "workspace_name": "la-br-th-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "ti": {<br>    "workspace_name": "la-br-ti-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "tu": {<br>    "workspace_name": "la-br-tu-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  }<br>}</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_repositorio"></a> [repositorio](#input\_repositorio) | Repositório do código da infraestrutura | `string` | `""` | no |
| <a name="input_subresource_name"></a> [subresource\_name](#input\_subresource\_name) | Tip do recurso para criação de private endpoint | `string` | `"registry"` | no |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_admin_enabled"></a> [acr\_admin\_enabled](#output\_acr\_admin\_enabled) | Azure Container Registry admin enabled |
| <a name="output_acr_location"></a> [acr\_location](#output\_acr\_location) | Localização da Azure Container Registry |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | Nome do Azure Container Registry |
| <a name="output_acr_rg_name"></a> [acr\_rg\_name](#output\_acr\_rg\_name) | Resource group do Azure Container Registry |
| <a name="output_acr_sku_name"></a> [acr\_sku\_name](#output\_acr\_sku\_name) | Sku do Azure Container Registry |
| <a name="output_backend_key"></a> [backend\_key](#output\_backend\_key) | Nome do tf state file |
| <a name="output_backend_sa"></a> [backend\_sa](#output\_backend\_sa) | Backend do tf state file |
| <a name="output_centro_custo"></a> [centro\_custo](#output\_centro\_custo) | Centro de custo do recurso |
| <a name="output_contador"></a> [contador](#output\_contador) | Contador do Recurso |
| <a name="output_diagsettings_enabled"></a> [diagsettings\_enabled](#output\_diagsettings\_enabled) | Diagnostic settings habilitado? |
| <a name="output_diagsettings_retention_days"></a> [diagsettings\_retention\_days](#output\_diagsettings\_retention\_days) | Nro dias retenção Diagnostic settings |
| <a name="output_environment"></a> [environment](#output\_environment) | Subscrição onde o recurso será criado |
| <a name="output_lock_enabled"></a> [lock\_enabled](#output\_lock\_enabled) | Habilitar resource lock? |
| <a name="output_lock_level"></a> [lock\_level](#output\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) |
| <a name="output_log_analytics_workspace"></a> [log\_analytics\_workspace](#output\_log\_analytics\_workspace) | Log analytics workspace |
| <a name="output_objective"></a> [objective](#output\_objective) | Objetivo do sistema/recurso |
| <a name="output_owner"></a> [owner](#output\_owner) | Responsável pelo sistema/recurso |
| <a name="output_repositorio"></a> [repositorio](#output\_repositorio) | Repositório do código da infraestrutura |
| <a name="output_system"></a> [system](#output\_system) | Sistema |
| <a name="output_tags_custom"></a> [tags\_custom](#output\_tags\_custom) | Tags customizadas |
