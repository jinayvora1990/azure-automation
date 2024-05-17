<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_key_vault_key.vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.crypto_encryption_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_administrator_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.acr_managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Whether the admin user is enabled. | `bool` | `false` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | List of VNet/Subnet IDs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_azure_services_bypass_allowed"></a> [azure\_services\_bypass\_allowed](#input\_azure\_services\_bypass\_allowed) | Whether to allow trusted Azure services to access a network restricted Container Registry. | `bool` | `false` | no |
| <a name="input_azurerm_key_vault_key"></a> [azurerm\_key\_vault\_key](#input\_azurerm\_key\_vault\_key) | Specifies the name of the Key Vault Key. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_data_endpoint_enabled"></a> [data\_endpoint\_enabled](#input\_data\_endpoint\_enabled) | Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU). | `bool` | `false` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Specifies whether encryption is enabled (Premium only) | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to provision resources | `string` | n/a | yes |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.<br>  Supported properties are:<br>    location                  = string<br>    zone\_redundancy\_enabled   = bool<br>    regional\_endpoint\_enabled = bool<br>    tags                      = map(string)<br>  or this can be a list of `string` (each element is a location) | `any` | `[]` | no |
| <a name="input_images_retention_days"></a> [images\_retention\_days](#input\_images\_retention\_days) | Specifies the number of images retention days. | `number` | `90` | no |
| <a name="input_images_retention_enabled"></a> [images\_retention\_enabled](#input\_images\_retention\_enabled) | Specifies whether images retention is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_kv_name"></a> [kv\_name](#input\_kv\_name) | The ID of the Key Vault where the Key should be created. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the Container Registry is accessible publicly. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of Azure Container Registry | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | Location of Container Registry | `string` | `"uaenorth"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |
| <a name="input_trust_policy_enabled"></a> [trust\_policy\_enabled](#input\_trust\_policy\_enabled) | Specifies whether the trust policy is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_user_assigned_identity_name"></a> [user\_assigned\_identity\_name](#input\_user\_assigned\_identity\_name) | Name of the User Assigned Managed Identity | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | Azure Container Registry Name |
| <a name="output_acr_rg"></a> [acr\_rg](#output\_acr\_rg) | Azure Container Registry Resource Group |
<!-- END_TF_DOCS -->