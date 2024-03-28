## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | (optional) values of access policy | <pre>list(object({<br>    object_id               = string<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    certificate_permissions = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_bypass"></a> [bypass](#input\_bypass) | Specifies which traffic can bypass the network rules. | `string` | `"None"` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | (The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. | `string` | `"Allow"` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | (Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | (Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Variable used as a prefix | `string` | `"shared"` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(any)` | `[]` | no |
| <a name="input_key_values"></a> [key\_values](#input\_key\_values) | (optional) values of key vault key | <pre>list(object({<br>    name     = string<br>    key_type = string<br>    key_size = optional(number)<br>    key_opts = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | location of key vault | `string` | `"uaenorth"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the key vault | `string` | n/a | yes |
| <a name="input_owners"></a> [owners](#input\_owners) | Project owners email address/AAD Group name | `string` | `""` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for this Key Vault. | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (optional) enable purge protection | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name of key vault | `string` | n/a | yes |
| <a name="input_secret_values"></a> [secret\_values](#input\_secret\_values) | (optional) values of key vault secrets | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (Optional) The number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | (Optional) One or more Subnet IDs which should be able to access this Key Vault. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_key_vault"></a> [azurerm\_key\_vault](#output\_azurerm\_key\_vault) | n/a |
