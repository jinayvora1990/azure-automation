<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.101.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_mysql_flexible_server.mysql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.mysql_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.mysql_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.mysql_admin_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subnet.mysql_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone of the MySQL Flexible Server. Possible values are 1, 2 and 3 | `string` | `"1"` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode which can be used to restore or replicate existing servers. Possible values are Default, Replica and Update. Support for PointInTimeRestore will be added later | `string` | `"Default"` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_groups                               = optional(set(string), ["allLogs"])<br>    metric_categories                        = optional(set(string), ["AllMetrics"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment that the cluster will be a part of. Eg: dev, qa, uat, sit, prod | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Is geo-redundant backup enabled. | `bool` | `false` | no |
| <a name="input_high_availability_enabled"></a> [high\_availability\_enabled](#input\_high\_availability\_enabled) | is high availability enabled for azure mysql flexible server | `bool` | `false` | no |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | n/a | <pre>object({<br>    name                     = string<br>    resource_group           = string<br>    mysql_admin_username_key = string<br>    mysql_admin_password_key = string<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the resource is created e.g. uaenorth. Changing this forces a new resource to be created. | `string` | `"uaenorth"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration | <pre>object({<br>    day_of_week  = number<br>    start_hour   = number<br>    start_minute = number<br>  })</pre> | `null` | no |
| <a name="input_mysql_storage"></a> [mysql\_storage](#input\_mysql\_storage) | MySQL storage configuration | <pre>object({<br>    auto_grow_enabled  = bool<br>    io_scaling_enabled = bool<br>    iops               = number<br>    size_gb            = number<br>  })</pre> | `null` | no |
| <a name="input_mysql_subnet"></a> [mysql\_subnet](#input\_mysql\_subnet) | Subnet to use with MySQL server | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | n/a | yes |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | Specifies the version of MySQL to use. Valid values are 5.7, 8.0.21 | `string` | `"8.0.21"` | no |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the MySQL DB | `string` | n/a | yes |
| <a name="input_server_configuration"></a> [server\_configuration](#input\_server\_configuration) | map for additional server configurations. See https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-server-parameters | <pre>map(object({<br>    config_value = string<br>  }))</pre> | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this MySQL flexible Server. The name of the SKU, follows the tier + family + cores pattern (e.g. D2s\_v3, D2ds\_v4). For available skus run `az mysql flexible-server list-skus --location=LOCATION` | `string` | n/a | yes |
| <a name="input_standby_availability_zone"></a> [standby\_availability\_zone](#input\_standby\_availability\_zone) | The Availability Zone of the standby Flexible Server. Possible values are 1, 2 and 3. | `string` | `"2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_fqdn"></a> [postgres\_fqdn](#output\_postgres\_fqdn) | n/a |
<!-- END_TF_DOCS -->