# Key Vault
* Key vault
* Secrets
* Log analytics
* App Insights
* Access policies
* Lock

## Nomenclatura

```
azu-kv-<subscription>-<namespace>-<camada>-<contador>

Sendo:
• azu: Azure cloud
•	kv: key vault
•	subscription: tu, ti, th, pr
•	namespace: nome do namespace
•	camada: camada onde se encontra o Key Vault
  - c1: frontEnd (cliente)
  - c2: aplicação
  - c3: banco de bados
•	contador: contador de 001-999

Exemplo:  azu-kv-tu-svdk-c2-001
```

## Acessos ao key vault

* Ambientes tu, ti, th e pr: acesso total para os grupos GD4250_SEGURANCA_IMP_AZ, GD4250_SEGURANCA_ACESSOS_AZ
* Ambientes tu e ti: acesso total ao grupo GD4253_DS_AZ e owner do key vault

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
* subscription diti GERENCIAMENTO
  + Network contributor no resource group "GERENCIAMENTO-VNET-RG"
  + Reader na subscription

## 2. Exemplo de recurso Azure provisionado com o módulo

[Projeto exemplo](https://bitbucket.bradesco.com.br:8443/projects/TFMOPBAN/repos/opbk-tf-examples/browse/kv-default)

## 3. Usar a versão latest do módulo

```
source = "git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-kv-default.git?ref=latest"
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

* [Arquivo backend.tf](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/backend.tf)

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

## 14. Como deletar um keyvault com soft delete habilitado

```bash
az keyvault list-deleted --resource-type vault -o table
az keyvault purge -n {VAULT NAME}
```

# 15. Arquivos de variáveis

## Variável global

* [terraform.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/terraform.tfvars)

<span style="color:red">Não colocar acentos e/ou caracteres especiais nos textos das tags, pois devido a Azure não suportar caracteres especiais nas tags ocorrerá erro na criação do recurso</span>

## Variáveis de ambiente - env_variables/_env.tfvars

Informações dos ambientes de tu, ti, th e pr de acordo com a necessidade do recurso Azure
* [env_variables/_tu.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/env_variables/_tu.tfvars)
* [env_variables/_ti.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/env_variables/_ti.tfvars)
* [env_variables/_th.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/env_variables/_th.tfvars)
* [env_variables/_pr.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/env_variables/_pr.tfvars)
* [env_variables/_do.tfvars](https://bitbucket.bradesco.com.br:8443/projects/tfmopban/repos/opbk-tf-examples/browse/kv-default/env_variables/_do.tfvars)

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

# 16. Documentação do módulo

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.97.0 |
| <a name="provider_azurerm.diti_gerenciamento"></a> [azurerm.diti\_gerenciamento](#provider\_azurerm.diti\_gerenciamento) | ~> 2.97.0 |
| <a name="provider_azurerm.shared_services"></a> [azurerm.shared\_services](#provider\_azurerm.shared\_services) | ~> 2.97.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-pvtend-default.git | latest |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-tags-default.git | latest |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.aks_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.apim_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.function_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.group_owner_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.group_owner_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.owner_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.synapse_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.vm_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.vmss_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.webapp_access_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.keyvault_secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_management_lock.resource_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.diasettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azuread_group.group_owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.group_owner_access_kv](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_user.user_owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_app_service.webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_service) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_function_app.function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/function_app) | data source |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_log_analytics_workspace.loganalytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_subnet.vnet_jumpserver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.vnet_pvtend_opbk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.vnet_pvtend_pltfrma](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_synapse_workspace.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/synapse_workspace) | data source |
| [azurerm_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_machine) | data source |
| [azurerm_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_machine_scale_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_key"></a> [backend\_key](#input\_backend\_key) | Nome do tf state file | `string` | `""` | no |
| <a name="input_backend_sa"></a> [backend\_sa](#input\_backend\_sa) | Backend do tf state file | `string` | `""` | no |
| <a name="input_centro_custo"></a> [centro\_custo](#input\_centro\_custo) | Centro de custo do recurso | `string` | `"opbk"` | no |
| <a name="input_certificate_permissions"></a> [certificate\_permissions](#input\_certificate\_permissions) | Permissões de certificados | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Update",<br>  "Create",<br>  "Import",<br>  "Delete",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "ManageContacts",<br>  "ManageIssuers",<br>  "GetIssuers",<br>  "ListIssuers",<br>  "SetIssuers",<br>  "DeleteIssuers",<br>  "Purge"<br>]</pre> | no |
| <a name="input_diagsettings_enabled"></a> [diagsettings\_enabled](#input\_diagsettings\_enabled) | Diagnostic settings habilitado? | `bool` | `false` | no |
| <a name="input_diagsettings_logs_category"></a> [diagsettings\_logs\_category](#input\_diagsettings\_logs\_category) | Categoria de logs do diagnostic settings | `map(any)` | <pre>{<br>  "AuditEvent": true,<br>  "AzurePolicyEvaluationDetails": false<br>}</pre> | no |
| <a name="input_diagsettings_metric_category"></a> [diagsettings\_metric\_category](#input\_diagsettings\_metric\_category) | Categoria de métricas do diagnostic settings | `map(any)` | <pre>{<br>  "AllMetrics": true<br>}</pre> | no |
| <a name="input_diagsettings_retention_days"></a> [diagsettings\_retention\_days](#input\_diagsettings\_retention\_days) | Nro dias retenção Diagnostic settings | `number` | `30` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscription que o recurso será criado | `string` | n/a | yes |
| <a name="input_group_owner"></a> [group\_owner](#input\_group\_owner) | Grupos com acesso ao key vault | `list(any)` | <pre>[<br>  "GD4253_DS_AZ",<br>  "GD4250_SEGURANCA_IMP_AZ",<br>  "GD4250_SEGURANCA_ACESSOS_AZ"<br>]</pre> | no |
| <a name="input_group_owner_access_kv"></a> [group\_owner\_access\_kv](#input\_group\_owner\_access\_kv) | Group owner do Key vault em tu e ti | `list(string)` | `[]` | no |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | Permissões de keys | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Update",<br>  "Create",<br>  "Import",<br>  "Delete",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "Decrypt",<br>  "Encrypt",<br>  "UnwrapKey",<br>  "WrapKey",<br>  "Verify",<br>  "Sign",<br>  "Purge"<br>]</pre> | no |
| <a name="input_kv_camada"></a> [kv\_camada](#input\_kv\_camada) | Camada do Key Vault | `string` | n/a | yes |
| <a name="input_kv_contador"></a> [kv\_contador](#input\_kv\_contador) | Contador do Key Vault | `number` | `1` | no |
| <a name="input_kv_default_action"></a> [kv\_default\_action](#input\_kv\_default\_action) | default\_action | `string` | `"Deny"` | no |
| <a name="input_kv_location"></a> [kv\_location](#input\_kv\_location) | Localização do key vault | `string` | `"brazilsouth"` | no |
| <a name="input_kv_namespace"></a> [kv\_namespace](#input\_kv\_namespace) | Namespace do Key Vault | `string` | n/a | yes |
| <a name="input_kv_resource_group_name"></a> [kv\_resource\_group\_name](#input\_kv\_resource\_group\_name) | Resource group do key vault | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete"<br>]</pre> | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | Log analytics workspace | <pre>map(object({<br>    workspace_name    = string<br>    workspace_rg_name = string<br>  }))</pre> | <pre>{<br>  "do": {<br>    "workspace_name": "azu-log-do-pltfrma-001",<br>    "workspace_rg_name": "azu-rg-do-pltfrma"<br>  },<br>  "pr": {<br>    "workspace_name": "la-br-pr-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "th": {<br>    "workspace_name": "la-br-th-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "ti": {<br>    "workspace_name": "la-br-ti-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  },<br>  "tu": {<br>    "workspace_name": "la-br-tu-openbanking-infra",<br>    "workspace_rg_name": "defaultresourcegroup-eus"<br>  }<br>}</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_owner_access_kv"></a> [owner\_access\_kv](#input\_owner\_access\_kv) | Owner do Key vault em tu e ti | `list(string)` | `[]` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Enable purge protection on tu, ti, th e do? | `string` | `false` | no |
| <a name="input_purge_protection_pr_enabled"></a> [purge\_protection\_pr\_enabled](#input\_purge\_protection\_pr\_enabled) | Enable purge protection on pr? | `string` | `true` | no |
| <a name="input_repositorio"></a> [repositorio](#input\_repositorio) | Repositório do código da infraestrutura | `string` | `""` | no |
| <a name="input_resource_certificate_permission"></a> [resource\_certificate\_permission](#input\_resource\_certificate\_permission) | Permissão para os recursos acessarem certificados | `list(string)` | <pre>[<br>  "Get"<br>]</pre> | no |
| <a name="input_resource_key_permission"></a> [resource\_key\_permission](#input\_resource\_key\_permission) | Permissão para os recursos acessarem keys | `list(string)` | <pre>[<br>  "Get"<br>]</pre> | no |
| <a name="input_resource_secret_permission"></a> [resource\_secret\_permission](#input\_resource\_secret\_permission) | Permissãp para os recursos acessarem secrets | `list(string)` | <pre>[<br>  "Get"<br>]</pre> | no |
| <a name="input_resources_access_kv"></a> [resources\_access\_kv](#input\_resources\_access\_kv) | Recursos com acesso ao key vault | `map(map(string))` | n/a | yes |
| <a name="input_sa_vnet_jumpserver"></a> [sa\_vnet\_jumpserver](#input\_sa\_vnet\_jumpserver) | Virtual network jump server | <pre>object({<br>    name                 = string<br>    virtual_network_name = string<br>    resource_group_name  = string<br>  })</pre> | <pre>{<br>  "name": "jumper-subnet",<br>  "resource_group_name": "GERENCIAMENTO-VNET-RG",<br>  "virtual_network_name": "GERENCIAMENTO-VNET"<br>}</pre> | no |
| <a name="input_sa_vnet_pvtend"></a> [sa\_vnet\_pvtend](#input\_sa\_vnet\_pvtend) | SA virtual network | <pre>map(object({<br>    name                 = string<br>    virtual_network_name = string<br>    resource_group_name  = string<br>  }))</pre> | <pre>{<br>  "do": {<br>    "name": "devops-pvtend",<br>    "resource_group_name": "azu-rg-do-vnet-devops",<br>    "virtual_network_name": "devops-vnet"<br>  },<br>  "pr": {<br>    "name": "pr-pvtend-subnet",<br>    "resource_group_name": "pvtend-vnet-rg",<br>    "virtual_network_name": "pvtend-vnet"<br>  },<br>  "th": {<br>    "name": "th-pvtend-subnet",<br>    "resource_group_name": "pvtend-vnet-rg",<br>    "virtual_network_name": "pvtend-vnet"<br>  },<br>  "ti": {<br>    "name": "ti-pvtend-subnet",<br>    "resource_group_name": "pvtend-vnet-rg",<br>    "virtual_network_name": "pvtend-vnet"<br>  },<br>  "tu": {<br>    "name": "tu-pvtend-subnet",<br>    "resource_group_name": "pvtend-vnet-rg",<br>    "virtual_network_name": "pvtend-vnet"<br>  }<br>}</pre> | no |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | Permissões de secrets | `list(any)` | <pre>[<br>  "Get",<br>  "List",<br>  "Set",<br>  "Delete",<br>  "Recover",<br>  "Backup",<br>  "Restore",<br>  "Purge"<br>]</pre> | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | secrets | `map(any)` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | sku\_name | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | soft\_delete\_retention\_days | `string` | `30` | no |
| <a name="input_sp_secret_permissions"></a> [sp\_secret\_permissions](#input\_sp\_secret\_permissions) | Permissões do service principal que é responsável pela gestão das secrets | `list(string)` | <pre>[<br>  "Get",<br>  "Set",<br>  "Delete",<br>  "Recover",<br>  "Purge"<br>]</pre> | no |
| <a name="input_subresource_name"></a> [subresource\_name](#input\_subresource\_name) | Tip do recurso para criação de private endpoint | `string` | `"vault"` | no |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_key"></a> [backend\_key](#output\_backend\_key) | Nome do tf state file |
| <a name="output_backend_sa"></a> [backend\_sa](#output\_backend\_sa) | Backend do tf state file |
| <a name="output_centro_custo"></a> [centro\_custo](#output\_centro\_custo) | Centro de custo do recurso |
| <a name="output_diagsettings_enabled"></a> [diagsettings\_enabled](#output\_diagsettings\_enabled) | Diagnostic settings habilitado? |
| <a name="output_diagsettings_retention_days"></a> [diagsettings\_retention\_days](#output\_diagsettings\_retention\_days) | Nro dias retenção Diagnostic settings |
| <a name="output_environment"></a> [environment](#output\_environment) | Subscrição onde o recurso será criado |
| <a name="output_group_owner_access_kv"></a> [group\_owner\_access\_kv](#output\_group\_owner\_access\_kv) | Group owner do Key vault em tu e ti |
| <a name="output_kv_camada"></a> [kv\_camada](#output\_kv\_camada) | Camada do Key Vault |
| <a name="output_kv_contador"></a> [kv\_contador](#output\_kv\_contador) | Contador do Key Vault |
| <a name="output_kv_location"></a> [kv\_location](#output\_kv\_location) | Localização do key vault |
| <a name="output_kv_name"></a> [kv\_name](#output\_kv\_name) | Nome do Key Vault |
| <a name="output_kv_namespace"></a> [kv\_namespace](#output\_kv\_namespace) | Namespace do Key Vault |
| <a name="output_kv_resource_group_name"></a> [kv\_resource\_group\_name](#output\_kv\_resource\_group\_name) | Resource group do Key Vault |
| <a name="output_lock_enabled"></a> [lock\_enabled](#output\_lock\_enabled) | Habilitar resource lock? |
| <a name="output_lock_level"></a> [lock\_level](#output\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) |
| <a name="output_log_analytics_workspace"></a> [log\_analytics\_workspace](#output\_log\_analytics\_workspace) | Log analytics workspace |
| <a name="output_objective"></a> [objective](#output\_objective) | Objetivo do sistema/recurso |
| <a name="output_owner"></a> [owner](#output\_owner) | Responsável pelo sistema/recurso |
| <a name="output_owner_access_kv"></a> [owner\_access\_kv](#output\_owner\_access\_kv) | Owner do Key vault em tu e ti |
| <a name="output_repositorio"></a> [repositorio](#output\_repositorio) | Repositório do código da infraestrutura |
| <a name="output_resources_access_kv"></a> [resources\_access\_kv](#output\_resources\_access\_kv) | Recursos com acesso ao key vault |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Secrets do key vault |
| <a name="output_secrets_name"></a> [secrets\_name](#output\_secrets\_name) | Nome das secrets do key vault |
| <a name="output_system"></a> [system](#output\_system) | Sistema |
| <a name="output_tags_custom"></a> [tags\_custom](#output\_tags\_custom) | Tags customizadas |
