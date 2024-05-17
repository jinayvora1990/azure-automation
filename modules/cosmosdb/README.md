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
| [azurerm_cosmosdb_account.cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_mongo_collection.mongo_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_collection) | resource |
| [azurerm_cosmosdb_mongo_database.mongo_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. | `list(string)` | `[]` | no |
| <a name="input_analytical_storage_enabled"></a> [analytical\_storage\_enabled](#input\_analytical\_storage\_enabled) | Enable Analytical Storage option for this Cosmos DB account. Defaults to `false`. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_analytical_storage_type"></a> [analytical\_storage\_type](#input\_analytical\_storage\_type) | The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`. | `string` | `null` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_backup"></a> [backup](#input\_backup) | Backup block with type (Continuous / Periodic), interval\_in\_minutes, retention\_in\_hours keys and storage\_redundancy | <pre>object({<br>    type                = string<br>    interval_in_minutes = number<br>    retention_in_hours  = number<br>    storage_redundancy  = string<br>  })</pre> | `null` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | Configures the capabilities to enable for this Cosmos DB account. Possible values are `AllowSelfServeUpgradeToMongo36`, `DisableRateLimitingResponses`, `EnableAggregationPipeline`, `EnableCassandra`, `EnableGremlin`, `EnableMongo`, `EnableTable`, `EnableServerless`, `MongoDBv3.4` and `mongoEnableDocLevelTTL`. | `list(string)` | n/a | yes |
| <a name="input_consistency_policy"></a> [consistency\_policy](#input\_consistency\_policy) | Consistency levels in Azure Cosmos DB | <pre>object({<br>    consistency_level       = string<br>    max_interval_in_seconds = optional(number)<br>    max_staleness_prefix    = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | MongoDB Databases | <pre>map(object({<br>    description    = optional(string)<br>    throughput     = optional(number)<br>    max_throughput = optional(number)<br>    collections = list(object({<br>      name           = string<br>      shard_key      = string<br>      throughput     = optional(number)<br>      max_throughput = optional(number)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_groups                               = optional(set(string), ["allLogs"])<br>    metric_categories                        = optional(set(string), ["Requests"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to provision resources | `string` | n/a | yes |
| <a name="input_failover_locations"></a> [failover\_locations](#input\_failover\_locations) | The name of the Azure region to host replicated data and their priority. | <pre>list(object(<br>    {<br>      location          = string<br>      failover_priority = number<br>      zone_redundant    = optional(bool)<br>    }<br>  ))</pre> | `null` | no |
| <a name="input_free_tier_enabled"></a> [free\_tier\_enabled](#input\_free\_tier\_enabled) | Enable the option to opt-in for the free database account within subscription. | `bool` | `false` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Enables virtual network filtering for this Cosmos DB account | `bool` | `false` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`. | `string` | `"MongoDB"` | no |
| <a name="input_managed_identity"></a> [managed\_identity](#input\_managed\_identity) | Specifies the type of Managed Service Identity that should be configured on this Cosmos Account. Possible value is only SystemAssigned. Defaults to false. | `bool` | `false` | no |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | The Server Version of a MongoDB account. See possible values https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account#mongo_server_version | `string` | `"4.2"` | no |
| <a name="input_network_acl_bypass_for_azure_services"></a> [network\_acl\_bypass\_for\_azure\_services](#input\_network\_acl\_bypass\_for\_azure\_services) | If azure services can bypass ACLs. | `bool` | `false` | no |
| <a name="input_network_acl_bypass_ids"></a> [network\_acl\_bypass\_ids](#input\_network\_acl\_bypass\_ids) | The list of resource Ids for Network Acl Bypass for this Cosmos DB account. | `list(string)` | `null` | no |
| <a name="input_offer_type"></a> [offer\_type](#input\_offer\_type) | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard. | `string` | `"Standard"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the backup vault | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | Region for the backup vault | `string` | `"uaenorth"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_virtual_network_rule"></a> [virtual\_network\_rule](#input\_virtual\_network\_rule) | Specifies a virtual\_network\_rules resource used to define which subnets are allowed to access this CosmosDB account | <pre>list(object({<br>    id                                   = string,<br>    ignore_missing_vnet_service_endpoint = bool<br>  }))</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->