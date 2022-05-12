# Azure Container Registry - Projeto exemplo
* ACR
* Log analytics
* Lock

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-acr-default.git | latest |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Nome do Azure Container Registry | `string` | n/a | yes |
| <a name="input_acr_rg_name"></a> [acr\_rg\_name](#input\_acr\_rg\_name) | Resource group do Azure Container Registry | `string` | n/a | yes |
| <a name="input_contador"></a> [contador](#input\_contador) | Contador do Azure Container Registry | `number` | n/a | yes |
| <a name="input_diagsettings_enabled"></a> [diagsettings\_enabled](#input\_diagsettings\_enabled) | Diagnostic settings habilitado? | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscription que o recurso será criado | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete",<br>  "ReadOnly"<br>]</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Nome do workspace do Log Analytics | `string` | n/a | yes |
| <a name="input_workspace_rg_name"></a> [workspace\_rg\_name](#input\_workspace\_rg\_name) | Nome do resource group do workspace Log Analytics | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_location"></a> [acr\_location](#output\_acr\_location) | Localização da API Management |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | Nome do API Management |
| <a name="output_acr_rg_name"></a> [acr\_rg\_name](#output\_acr\_rg\_name) | Resource group do API Management |
| <a name="output_contador"></a> [contador](#output\_contador) | Contador do API Management |
| <a name="output_environment"></a> [environment](#output\_environment) | Subscrição onde o recurso será criado |
| <a name="output_objective"></a> [objective](#output\_objective) | Objetivo do sistema/recurso |
| <a name="output_owner"></a> [owner](#output\_owner) | Responsável pelo sistema/recurso |
| <a name="output_system"></a> [system](#output\_system) | Sistema |
| <a name="output_tags_custom"></a> [tags\_custom](#output\_tags\_custom) | Tags customizadas |
