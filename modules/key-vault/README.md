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
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_contacts"></a> [contacts](#input\_contacts) | A map of contacts for the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. | <pre>map(object({<br>    email = string<br>    name  = optional(string, null)<br>    phone = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_groups                               = optional(set(string), ["allLogs"])<br>    metric_categories                        = optional(set(string), ["AllMetrics"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | (Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | (Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to provision resources | `string` | n/a | yes |
| <a name="input_lock"></a> [lock](#input\_lock) | The lock level to apply to the Key Vault. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`. | <pre>object({<br>    name = optional(string, null)<br>    kind = optional(string, "None")<br>  })</pre> | `{}` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | The network ACL configuration for the Key Vault.<br>If not specified then the Key Vault will be created with a firewall that blocks access.<br>Specify `null` to create the Key Vault with no firewall.<br><br>- `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br>- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.<br>- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br>    bypass                     = optional(string, "None")<br>    default_action             = optional(string, "Deny")<br>    ip_rules                   = optional(list(string), [])<br>    virtual_network_subnet_ids = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | Project owners email address/AAD Group name | `string` | `""` | no |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for this Key Vault. | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (optional) enable purge protection | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name of key vault | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of key vault | `string` | `"uaenorth"` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | A map of role assignments to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.<br>- `principal_id` - The ID of the principal to assign the role to.<br>- `description` - The description of the role assignment.<br>- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.<br>- `condition` - The condition which will be used to scope the role assignment.<br>- `condition_version` - The version of the condition syntax. If you are using a condition, valid values are '2.0'.<br><br>> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal. | <pre>map(object({<br>    role_definition_id_or_name             = string<br>    principal_id                           = string<br>    description                            = optional(string, null)<br>    skip_service_principal_aad_check       = optional(bool, false)<br>    condition                              = optional(string, null)<br>    condition_version                      = optional(string, null)<br>    delegated_managed_identity_resource_id = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (Optional) The number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_key_vault"></a> [azurerm\_key\_vault](#output\_azurerm\_key\_vault) | n/a |
<!-- END_TF_DOCS -->