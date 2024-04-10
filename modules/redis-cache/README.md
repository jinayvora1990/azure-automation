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
| [azurerm_monitor_diagnostic_setting.extaudit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_redis_cache.rediscache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_log_analytics_workspace.log_ws](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_endpoint_connection.pep_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_storage_account.aof_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.rdb_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.redis_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aof_backup_enabled"></a> [aof\_backup\_enabled](#input\_aof\_backup\_enabled) | AOF backup ennabled | `bool` | `false` | no |
| <a name="input_aof_storage_account"></a> [aof\_storage\_account](#input\_aof\_storage\_account) | Storage Account details to store aof backups. | <pre>object({<br>    storage_account_name = string,<br>    resource_group_name  = string<br>  })</pre> | `null` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | `""` | no |
| <a name="input_cache_eviction_policy"></a> [cache\_eviction\_policy](#input\_cache\_eviction\_policy) | Redis cache key eviction policy | `string` | `"volatile-lru"` | no |
| <a name="input_cache_tier"></a> [cache\_tier](#input\_cache\_tier) | This is the tier of the cache that is provisioned | <pre>object({<br>    family   = string<br>    capacity = number<br>    sku_name = string<br>  })</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment where redis cache is provisioned | `string` | `"dev"` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | The numeric id of the resource being provisioned | `number` | `1` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | Log Analytics workspace | <pre>object({<br>    workspace_name      = string<br>    resource_group_name = string<br>  })</pre> | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Minimum TLS version to be used with redis cache | `string` | `"1.2"` | no |
| <a name="input_patch_schedules"></a> [patch\_schedules](#input\_patch\_schedules) | Maintenance schedule of the redis cache. | <pre>list(object({<br>    day_of_week    = string<br>    start_hour_utc = number<br>  }))</pre> | n/a | yes |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_rdb_backup_configuration"></a> [rdb\_backup\_configuration](#input\_rdb\_backup\_configuration) | RDB Backup Confifuration | <pre>object({<br>    backup_frequency          = number<br>    max_snapshot_count        = number<br>    storage_connection_string = string<br>  })</pre> | <pre>{<br>  "backup_frequency": 0,<br>  "max_snapshot_count": 0,<br>  "storage_connection_string": ""<br>}</pre> | no |
| <a name="input_rdb_backup_enabled"></a> [rdb\_backup\_enabled](#input\_rdb\_backup\_enabled) | RDB backup ennabled | `bool` | `false` | no |
| <a name="input_rdb_storage_account"></a> [rdb\_storage\_account](#input\_rdb\_storage\_account) | Storage Account details to store rdb backups. | <pre>object({<br>    storage_account_name = string,<br>    resource_group_name  = string<br>  })</pre> | `null` | no |
| <a name="input_redis_cache_name"></a> [redis\_cache\_name](#input\_redis\_cache\_name) | The name of the redis cache resource created | `string` | n/a | yes |
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
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the redis cache |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the redis cache |
| <a name="output_redis_cache_private_endpoint"></a> [redis\_cache\_private\_endpoint](#output\_redis\_cache\_private\_endpoint) | id of the Redis Cache Private Endpoint |
| <a name="output_redis_cache_private_endpoint_ip"></a> [redis\_cache\_private\_endpoint\_ip](#output\_redis\_cache\_private\_endpoint\_ip) | Redis Cache server private endpoint IPv4 Addresses |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the redis cache |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string for the redis cache |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | ssl port of the redis cache |
