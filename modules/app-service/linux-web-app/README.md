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

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate) | resource |
| [azurerm_app_service_certificate_binding.certificate_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_linux_web_app.linux-web-app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_storage_container.backup_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_service_plan.existing_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan) | data source |
| [azurerm_storage_account.backup_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account_blob_container_sas.container_sas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_blob_container_sas) | data source |
| [azurerm_subnet.app_service_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights"></a> [application\_insights](#input\_application\_insights) | The log analytics workspace to be used for the app insights | <pre>object({<br>    enabled = bool<br>    log_analytics_ws = optional(object({<br>      name           = string<br>      resource_group = string<br>    }))<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_artifact_url"></a> [artifact\_url](#input\_artifact\_url) | The url for the artifact to run | `string` | `null` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | The backup configuration for the app service. Skip this for the default backup configuration | <pre>object({<br>    backup_sa = object({<br>      name           = string<br>      resource_group = string<br>    })<br>    enabled = optional(bool)<br>    schedule = object({<br>      frequency_interval       = number<br>      frequency_unit           = string<br>      start_time               = optional(string)<br>      retention_period_days    = optional(number)<br>      keep_at_least_one_backup = optional(bool)<br>    })<br>  })</pre> | `null` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | Map a custom domain with the app service. If you do not pass the certificate, a managed certificate is created by azure | <pre>object({<br>    hostname = string<br>    certificate = object({<br>      name = string<br>      vault = object({<br>        name           = string<br>        resource_group = string<br>      })<br>    })<br>  })</pre> | `null` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | The environment variables map | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_existing_service_plan"></a> [existing\_service\_plan](#input\_existing\_service\_plan) | The details of an existing service plan | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | `null` | no |
| <a name="input_logs"></a> [logs](#input\_logs) | The logging configuration for the app service | <pre>object({<br>    application_logs = object({<br>      file_system_level = string<br>    })<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Status of public network access to the web app | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_service_plan_sku"></a> [service\_plan\_sku](#input\_service\_plan\_sku) | The SKU for the service plan | `string` | `"B1"` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for App Service. | <pre>object({<br>    always_on                         = optional(bool)<br>    app_command_line                  = optional(string)<br>    default_documents                 = optional(list(string))<br>    ftps_state                        = optional(string)<br>    health_check_path                 = optional(string)<br>    health_check_eviction_time_in_min = optional(string)<br>    http2_enabled                     = optional(string)<br>    load_balancing_mode               = optional(string)<br>    application_stack                 = optional(map(string))<br>    cidr_restriction = optional(list(object({<br>      name     = optional(string)<br>      priority = optional(number)<br>      action   = optional(string)<br>      cidr     = optional(string)<br>      #       headers  = optional(object({}))<br>    })), [])<br>    subnet_restriction = optional(list(object({<br>      name      = optional(string)<br>      priority  = optional(number)<br>      action    = optional(string)<br>      subnet_id = optional(string)<br>      #       headers   = optional(object({}))<br>    })), [])<br>    service_tags_restriction = optional(list(object({<br>      name        = optional(string)<br>      priority    = optional(number)<br>      action      = optional(string)<br>      service_tag = optional(string)<br>      #       headers     = optional(object({}))<br>    })), [])<br>    default_ip_restriction_action = optional(string)<br>    cors = optional(object({<br>      allowed_origins     = optional(list(string))<br>      support_credentials = optional(bool)<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_web_app_subnet"></a> [web\_app\_subnet](#input\_web\_app\_subnet) | The subnet id which will be used by this Web App for regional virtual network integration. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of workers assigned to the service plan and the app-service | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The default hostname of the linux web app |
| <a name="output_id"></a> [id](#output\_id) | The id of the linux web app |
| <a name="output_kind"></a> [kind](#output\_kind) | The kind of the linux web app |
| <a name="output_name"></a> [name](#output\_name) | The name of the linux web app |
<!-- END_TF_DOCS -->