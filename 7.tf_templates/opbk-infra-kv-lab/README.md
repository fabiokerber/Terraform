# Key Vault para recursos da VS Plataforma no laboratorio de desenvolvimento
* Key vault
* Secrets
* Log analytics
* Access policies
* Lock

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.5 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | git::https://bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-kv-default.git | latest |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagsettings_enabled"></a> [diagsettings\_enabled](#input\_diagsettings\_enabled) | Diagnostic settings habilitado? | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Subscrição onde o recurso será criado | `string` | n/a | yes |
| <a name="input_kv_camada"></a> [kv\_camada](#input\_kv\_camada) | Camada do Key Vault | `string` | n/a | yes |
| <a name="input_kv_contador"></a> [kv\_contador](#input\_kv\_contador) | Contador do Key Vault | `number` | n/a | yes |
| <a name="input_kv_namespace"></a> [kv\_namespace](#input\_kv\_namespace) | Namespace do Key Vault | `string` | n/a | yes |
| <a name="input_kv_resource_group_name"></a> [kv\_resource\_group\_name](#input\_kv\_resource\_group\_name) | Resource group do key vault | `string` | n/a | yes |
| <a name="input_lock_enabled"></a> [lock\_enabled](#input\_lock\_enabled) | Habilitar resource lock? | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Resource lock level (CanNotDelete/ReadOnly) | `list(string)` | <pre>[<br>  "CanNotDelete"<br>]</pre> | no |
| <a name="input_objective"></a> [objective](#input\_objective) | Objetivo do sistema/recurso | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Responsável pelo sistema/recurso | `string` | n/a | yes |
| <a name="input_owner_access_kv"></a> [owner\_access\_kv](#input\_owner\_access\_kv) | Owner do Key vault em tu e ti | `list(any)` | n/a | yes |
| <a name="input_resources_access_kv"></a> [resources\_access\_kv](#input\_resources\_access\_kv) | Recursos com acesso ao key vault | `map(map(string))` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | secrets | `map(any)` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Sistema | `string` | n/a | yes |
| <a name="input_tags_custom"></a> [tags\_custom](#input\_tags\_custom) | Tags customizadas | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kv_name"></a> [kv\_name](#output\_kv\_name) | Nome do Key vault |
| <a name="output_kv_resource_group_name"></a> [kv\_resource\_group\_name](#output\_kv\_resource\_group\_name) | Resource group do Key vault |
| <a name="output_owner_access_kv"></a> [owner\_access\_kv](#output\_owner\_access\_kv) | Owner do Key vault em tu e ti |
| <a name="output_secrets_name"></a> [secrets\_name](#output\_secrets\_name) | Secrets do key vault |
