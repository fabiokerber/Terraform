# Resource Group para recursos de laboratório DevOps da Azure

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.5 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resourcegroup"></a> [resourcegroup](#module\_resourcegroup) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-rg-default.git | latest |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Subscription que o recurso será criado | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete"<br>]</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Nome do resource group | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | Subscription que o recurso será criado |
| <a name="output_lock_enabled"></a> [lock\_enabled](#output\_lock\_enabled) | Habilitar resource lock? |
| <a name="output_lock_level"></a> [lock\_level](#output\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) |
| <a name="output_objective"></a> [objective](#output\_objective) | Objetivo do sistema/recurso |
| <a name="output_owner"></a> [owner](#output\_owner) | Responsável pelo sistema/recurso |
| <a name="output_rg_location"></a> [rg\_location](#output\_rg\_location) | Localização onde será criado o resource group |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Nome do resource group |
| <a name="output_system"></a> [system](#output\_system) | Sistema |
| <a name="output_tags_custom"></a> [tags\_custom](#output\_tags\_custom) | Tags customizadas |
