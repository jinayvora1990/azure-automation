<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_res-id"></a> [res-id](#module\_res-id) | ../utility/random-identifier | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_namespace.eh-namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.role-assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.storage_account_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.sa_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_auto_inflate_enabled"></a> [auto\_inflate\_enabled](#input\_auto\_inflate\_enabled) | Is Auto Inflate enabled for the EventHub Namespace | `bool` | `false` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | Specifies the Capacity / Throughput Units for a Standard SKU namespace. | `number` | `1` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_groups                               = optional(set(string), ["allLogs"])<br>    metric_categories                        = optional(set(string), ["AllMetrics"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_eventhub_config"></a> [eventhub\_config](#input\_eventhub\_config) | List of eventhub instances(topics) and their configuration to be created in the namespace | <pre>list(object({<br>    name              = string<br>    message_retention = number<br>    partition_count   = number<br>    eventhub_status   = optional(string, "Active")<br>    enable_capture    = optional(bool, false)<br>    capture_config = optional(object({<br>      encoding            = string<br>      interval_in_seconds = optional(number)<br>      size_limit_in_bytes = optional(number)<br>      skip_empty_archives = optional(bool)<br>      destination = object({<br>        blob_container_name = string<br>        storage_account_id  = string<br>      })<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_maximum_throughput_units"></a> [maximum\_throughput\_units](#input\_maximum\_throughput\_units) | Specifies the maximum number of throughput units when Auto Inflate is Enabled. | `number` | `null` | no |
| <a name="input_network_rulesets"></a> [network\_rulesets](#input\_network\_rulesets) | n/a | <pre>object({<br>    default_action                 = string<br>    trusted_service_access_enabled = optional(bool)<br>    virtual_network_rules = optional(list(object({<br>      subnet_id                                       = string<br>      ignore_missing_virtual_network_service_endpoint = optional(bool)<br>    })), [])<br>    ip_rules = optional(list(object({<br>      ip_mask = string<br>      action  = optional(string)<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Is public network access enabled for the EventHub Namespace | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The sku for the eventhub namespace | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Is the eventhub namespace zone redundant | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_id"></a> [eventhub\_id](#output\_eventhub\_id) | The id of the eventhub |
| <a name="output_eventhub_namespace"></a> [eventhub\_namespace](#output\_eventhub\_namespace) | The eventhub namespace name |
| <a name="output_eventhub_partition_ids"></a> [eventhub\_partition\_ids](#output\_eventhub\_partition\_ids) | The list of partition ids of the eventhub |
<!-- END_TF_DOCS -->