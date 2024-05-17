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
| <a name="module_app-insights"></a> [app-insights](#module\_app-insights) | ../../monitoring/app-insights | n/a |
| <a name="module_res-id"></a> [res-id](#module\_res-id) | ../../utility/random-identifier | n/a |
| <a name="module_service-plan"></a> [service-plan](#module\_service-plan) | ../app-service-plan | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ../../storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app.function-app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_storage_container.backup_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_service_plan.existing_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan) | data source |
| [azurerm_storage_account.backup_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account_blob_container_sas.container_sas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_blob_container_sas) | data source |
| [azurerm_subnet.app_service_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_function_subnet"></a> [app\_function\_subnet](#input\_app\_function\_subnet) | The subnet id which will be used by this function app for regional virtual network integration. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_application_insights_enabled"></a> [application\_insights\_enabled](#input\_application\_insights\_enabled) | Use Application Insights for this App Service | `bool` | `false` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_artifact_url"></a> [artifact\_url](#input\_artifact\_url) | The url for the artifact to run | `string` | `null` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | The backup configuration for the app service. Skip this for the default backup configuration | <pre>object({<br>    backup_sa = object({<br>      name           = string<br>      resource_group = string<br>    })<br>    enabled = optional(bool)<br>    schedule = object({<br>      frequency_interval       = number<br>      frequency_unit           = string<br>      start_time               = optional(string)<br>      retention_period_days    = optional(number)<br>      keep_at_least_one_backup = optional(bool)<br>    })<br>  })</pre> | `null` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_daily_memory_time_quota"></a> [daily\_memory\_time\_quota](#input\_daily\_memory\_time\_quota) | The amount of memory in gigabyte-seconds that the application is allowed to consume per day. | `number` | `null` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | The environment variables map | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_existing_service_plan"></a> [existing\_service\_plan](#input\_existing\_service\_plan) | The details of an existing service plan | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | `null` | no |
| <a name="input_log_analytics_ws"></a> [log\_analytics\_ws](#input\_log\_analytics\_ws) | The log analytics workspace to be used for the app insights | <pre>object({<br>    name           = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_max_elastic_worker_count"></a> [max\_elastic\_worker\_count](#input\_max\_elastic\_worker\_count) | The maximum elastic workers present in a elastic service plan | `number` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Status of public network access to the app function | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_service_plan_sku"></a> [service\_plan\_sku](#input\_service\_plan\_sku) | The SKU for the service plan | `string` | `"Y1"` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for App Service. | <pre>object({<br>    always_on                         = optional(bool)<br>    app_command_line                  = optional(string)<br>    default_documents                 = optional(list(string))<br>    ftps_state                        = optional(string)<br>    health_check_path                 = optional(string)<br>    health_check_eviction_time_in_min = optional(string)<br>    http2_enabled                     = optional(string)<br>    load_balancing_mode               = optional(string)<br>    app_scale_limit                   = optional(string)<br>    elastic_instance_minimum          = optional(string)<br>    pre_warmed_instance_count         = optional(string)<br>    application_stack                 = optional(map(string))<br>    app_service_logs = optional(object({<br>      disk_quota_mb         = number<br>      retention_period_days = number<br>    }))<br>    cidr_restriction = optional(list(object({<br>      name     = optional(string)<br>      priority = optional(number)<br>      action   = optional(string)<br>      cidr     = optional(string)<br>      #       headers  = optional(object({}))<br>    })), [])<br>    subnet_restriction = optional(list(object({<br>      name      = optional(string)<br>      priority  = optional(number)<br>      action    = optional(string)<br>      subnet_id = optional(string)<br>      #       headers   = optional(object({}))<br>    })), [])<br>    service_tags_restriction = optional(list(object({<br>      name        = optional(string)<br>      priority    = optional(number)<br>      action      = optional(string)<br>      service_tag = optional(string)<br>      #       headers     = optional(object({}))<br>    })), [])<br>    default_ip_restriction_action = optional(string)<br>    cors = optional(object({<br>      allowed_origins     = optional(list(string))<br>      support_credentials = optional(bool)<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_storage_account_name"></a> [backend\_storage\_account\_name](#output\_backend\_storage\_account\_name) | The name of the backend storage account used for the function app |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The default hostname of the function app |
| <a name="output_id"></a> [id](#output\_id) | The id of the function app |
| <a name="output_name"></a> [name](#output\_name) | The name of the function app |
<!-- END_TF_DOCS -->