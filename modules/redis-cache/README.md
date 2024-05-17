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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_res-id"></a> [res-id](#module\_res-id) | ../utility/random-identifier | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_dns_a_record.dns_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_redis_cache.rediscache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_private_endpoint_connection.pep_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_storage_account.aof_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.rdb_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.redis_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aof_backup_enabled"></a> [aof\_backup\_enabled](#input\_aof\_backup\_enabled) | AOF backup enabled | `bool` | `false` | no |
| <a name="input_aof_storage_account"></a> [aof\_storage\_account](#input\_aof\_storage\_account) | Storage Account details to store aof backups. | <pre>object({<br>    storage_account_name = string,<br>    resource_group_name  = string<br>  })</pre> | `null` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_cache_eviction_policy"></a> [cache\_eviction\_policy](#input\_cache\_eviction\_policy) | Redis cache key eviction policy | `string` | `"volatile-lru"` | no |
| <a name="input_cache_tier"></a> [cache\_tier](#input\_cache\_tier) | This is the tier of the cache that is provisioned | <pre>object({<br>    family   = string<br>    capacity = number<br>    sku_name = string<br>  })</pre> | n/a | yes |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_groups                               = optional(set(string), ["allLogs"])<br>    metric_categories                        = optional(set(string), ["AllMetrics"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | `"dev"` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Minimum TLS version to be used with redis cache | `string` | `"1.2"` | no |
| <a name="input_patch_schedules"></a> [patch\_schedules](#input\_patch\_schedules) | Maintenance schedule of the redis cache. | <pre>list(object({<br>    day_of_week    = string<br>    start_hour_utc = number<br>  }))</pre> | `null` | no |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Name of the private dns zone for private link | `string` | `null` | no |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_rdb_backup_configuration"></a> [rdb\_backup\_configuration](#input\_rdb\_backup\_configuration) | RDB Backup Configuration | <pre>object({<br>    backup_frequency          = number<br>    max_snapshot_count        = number<br>    storage_connection_string = string<br>  })</pre> | <pre>{<br>  "backup_frequency": 0,<br>  "max_snapshot_count": 0,<br>  "storage_connection_string": ""<br>}</pre> | no |
| <a name="input_rdb_backup_enabled"></a> [rdb\_backup\_enabled](#input\_rdb\_backup\_enabled) | RDB backup enabled | `bool` | `false` | no |
| <a name="input_rdb_storage_account"></a> [rdb\_storage\_account](#input\_rdb\_storage\_account) | Storage Account details to store rdb backups. | <pre>object({<br>    storage_account_name = string,<br>    resource_group_name  = string<br>  })</pre> | `null` | no |
| <a name="input_redis_subnet"></a> [redis\_subnet](#input\_redis\_subnet) | Subnet where the redis cache is provisioned. This subnet needs to have only the redis in the subnet. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | The number of replicas of the primary | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards in the redis cache | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | Hostname of the redis-cache |
| <a name="output_pep_pvt_dns_fqdn"></a> [pep\_pvt\_dns\_fqdn](#output\_pep\_pvt\_dns\_fqdn) | FQDN for the redis cache private endpoint in private dns zone |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the redis cache |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the redis cache |
| <a name="output_redis_cache_private_endpoint_ip"></a> [redis\_cache\_private\_endpoint\_ip](#output\_redis\_cache\_private\_endpoint\_ip) | Redis Cache server private endpoint IPv4 Addresses |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the redis cache |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string for the redis cache |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | ssl port of the redis cache |
<!-- END_TF_DOCS -->