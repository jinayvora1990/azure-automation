## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.postgres_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.postgres_pgbouncer_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.postgres_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.postgres_admin_username](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_pgbouncer_settings"></a> [additional\_pgbouncer\_settings](#input\_additional\_pgbouncer\_settings) | map for additional pgbouncer settings. Remember to set `pgbouncer.enabled` to true in server\_configuration | <pre>map(object({<br>    config_value = string<br>  }))</pre> | `{}` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone of the PostgreSQL Flexible Server. Possible values are 1, 2 and 3 | `string` | `"1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment that the cluster will be a part of. Eg: dev, qa, uat, sit, prod | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Is geo-redundant backup enabled. | `bool` | `false` | no |
| <a name="input_high_availability_enabled"></a> [high\_availability\_enabled](#input\_high\_availability\_enabled) | is high availability enabled for azure postgresql flexible server | `bool` | `false` | no |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | n/a | <pre>object({<br>    name                        = string<br>    resource_group              = string<br>    postgres_admin_username_key = string<br>    postgres_admin_password_key = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the resource is created e.g. uaenorth. Changing this forces a new resource to be created. | `string` | `"uaenorth"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration | <pre>object({<br>    day_of_week  = number<br>    start_hour   = number<br>    start_minute = number<br>  })</pre> | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Existing resource group | `string` | `null` | no |
| <a name="input_server_configuration"></a> [server\_configuration](#input\_server\_configuration) | map for additional server configurations. See https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-server-parameters | <pre>map(object({<br>    config_value = string<br>  }))</pre> | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this PostgreSQL flexible Server. The name of the SKU, follows the tier + family + cores pattern (e.g. D2s\_v3, D2ds\_v4). For available skus run `az postgres flexible-server list-skus --location=LOCATION` | `string` | n/a | yes |
| <a name="input_sql_version"></a> [sql\_version](#input\_sql\_version) | Specifies the version of PostgreSQL to use. Valid values are 11, 12, 13, 14, 15, 16 | `string` | `"11"` | no |
| <a name="input_standby_availability_zone"></a> [standby\_availability\_zone](#input\_standby\_availability\_zone) | The Availability Zone of the standby Flexible Server. Possible values are 1, 2 and 3. | `string` | `"2"` | no |
| <a name="input_storage_in_mb"></a> [storage\_in\_mb](#input\_storage\_in\_mb) | Max storage allowed for a server (5120 - 4194304) | `string` | `"262144"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet to use with PostgreSQL server | <pre>object({<br>    name           = string<br>    vnet           = string<br>    resource_group = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of virtual network. You must also provide virtual\_network\_resource\_group | `string` | `null` | no |
| <a name="input_virtual_network_resource_group"></a> [virtual\_network\_resource\_group](#input\_virtual\_network\_resource\_group) | Name of virtual network resource group | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_fqdn"></a> [postgres\_fqdn](#output\_postgres\_fqdn) | n/a |
