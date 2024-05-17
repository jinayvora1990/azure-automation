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
| [azurerm_app_service_environment_v3.ase](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_subnet.ase_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_new_private_endpoint_connections"></a> [allow\_new\_private\_endpoint\_connections](#input\_allow\_new\_private\_endpoint\_connections) | (Optional) Should new Private Endpoint Connections be allowed | `bool` | `null` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_ase_subnet"></a> [ase\_subnet](#input\_ase\_subnet) | Subnet to use for App Service Environment | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_setting"></a> [cluster\_setting](#input\_cluster\_setting) | (Optional) Cluster settings for ASE v3 | <pre>list(object({<br>    name  = string<br>    value = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_dedicated_host_count"></a> [dedicated\_host\_count](#input\_dedicated\_host\_count) | (Optional) This ASEv3 should use dedicated Hosts | `number` | `null` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_internal_load_balancing_mode"></a> [internal\_load\_balancing\_mode](#input\_internal\_load\_balancing\_mode) | (Optional) Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment. Possible values are None (for an External VIP Type), and 'Web, Publishing' (for an Internal VIP Type). | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | (Optional) Set to true to deploy the ASEv3 with availability zones supported | `bool` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->