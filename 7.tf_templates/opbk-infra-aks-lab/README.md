# Aks - Projeto exemplo
* Aks
* Node pools
* Log analytics

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-aks-default.git | refactoring |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr"></a> [acr](#input\_acr) | Azure Container Registry | <pre>object({<br>    acr_name    = string<br>    acr_rg_name = string<br>  })</pre> | n/a | yes |
| <a name="input_aks_contador"></a> [aks\_contador](#input\_aks\_contador) | Contador do aks | `number` | n/a | yes |
| <a name="input_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#input\_aks\_kubernetes\_version) | Versão kubernetes do aks | `string` | n/a | yes |
| <a name="input_aks_name"></a> [aks\_name](#input\_aks\_name) | Nome do aks | `string` | n/a | yes |
| <a name="input_aks_node_pool"></a> [aks\_node\_pool](#input\_aks\_node\_pool) | Propriedades do aks node pool | <pre>map(object({<br>    name                   = string<br>    vm_size                = string<br>    node_count             = number<br>    enable_auto_scaling    = bool<br>    enable_host_encryption = bool<br>    enable_node_public_ip  = bool<br>    max_pods               = number<br>    max_count              = number<br>    min_count              = number<br>    orchestrator_version   = string<br>    os_disk_size_gb        = number<br>    os_disk_type           = string<br>    mode                   = string<br>  }))</pre> | n/a | yes |
| <a name="input_aks_rg_name"></a> [aks\_rg\_name](#input\_aks\_rg\_name) | Resource group do Cluster AKS | `string` | n/a | yes |
| <a name="input_aks_system_node_pool"></a> [aks\_system\_node\_pool](#input\_aks\_system\_node\_pool) | Propriedades do aks system node pool | <pre>object({<br>    enable_auto_scaling    = bool<br>    enable_host_encryption = bool<br>    enable_node_public_ip  = bool<br>    max_pods               = number<br>    name                   = string<br>    node_count             = number<br>    max_count              = number<br>    min_count              = number<br>    orchestrator_version   = string<br>    os_disk_size_gb        = number<br>    os_disk_type           = string<br>    type                   = string<br>    vm_size                = string<br>  })</pre> | n/a | yes |
| <a name="input_aks_vnet_subnet"></a> [aks\_vnet\_subnet](#input\_aks\_vnet\_subnet) | Vnet e subnet do aks | <pre>object({<br>    subnet_name  = string<br>    vnet_name    = string<br>    vnet_rg_name = string<br>  })</pre> | n/a | yes |
| <a name="input_backend_key"></a> [backend\_key](#input\_backend\_key) | Nome do tf state file | `string` | `""` | no |
| <a name="input_backend_sa"></a> [backend\_sa](#input\_backend\_sa) | Backend do tf state file | `string` | `""` | no |
| <a name="input_diagsettings_enabled"></a> [diagsettings\_enabled](#input\_diagsettings\_enabled) | Diagnostic settings habilitado? | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscrição onde o recurso será criado | `string` | n/a | yes |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_repositorio"></a> [repositorio](#input\_repositorio) | Repositório do código da infraestrutura | `string` | `""` | no |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_kubernetes_version"></a> [aks\_kubernetes\_version](#output\_aks\_kubernetes\_version) | Versão kubernetes do aks |
| <a name="output_aks_location"></a> [aks\_location](#output\_aks\_location) | Localização do Cluster AKS |
| <a name="output_aks_name"></a> [aks\_name](#output\_aks\_name) | Nome do Cluster AKS |
| <a name="output_aks_rg_name"></a> [aks\_rg\_name](#output\_aks\_rg\_name) | Resource group do Cluster AKS |
| <a name="output_diagsettings_enabled"></a> [diagsettings\_enabled](#output\_diagsettings\_enabled) | Diagnostic settings habilitado? |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | Quantidade máxima de pod alocadas no default nodepool |
| <a name="output_orchestrator_version"></a> [orchestrator\_version](#output\_orchestrator\_version) | Versão do Kubernetes do default nodepool |
| <a name="output_os_disk_size_gb"></a> [os\_disk\_size\_gb](#output\_os\_disk\_size\_gb) | Tamanho do disco o Systema Operacional do default nodepool |
| <a name="output_vm_size"></a> [vm\_size](#output\_vm\_size) | Tamanhos das máquinas virtuais na Azure usadas pelo default nodepool(https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes) |
