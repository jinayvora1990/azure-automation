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
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | Type of application insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. | `string` | n/a | yes |
| <a name="input_daily_data_cap_in_gb"></a> [daily\_data\_cap\_in\_gb](#input\_daily\_data\_cap\_in\_gb) | Specifies the Application Insights component daily data volume cap in GB. | `string` | `null` | no |
| <a name="input_daily_data_cap_notifications_disabled"></a> [daily\_data\_cap\_notifications\_disabled](#input\_daily\_data\_cap\_notifications\_disabled) | Specifies if a notification email will be send when the daily data volume cap is met. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Should the Application Insights component support ingestion over the Public Internet? | `bool` | `false` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Should the Application Insights component support querying over the Public Internet? | `bool` | `false` | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Disable Non-Azure AD based Auth. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the retention period in days. | `number` | `90` | no |
| <a name="input_sampling_percentage"></a> [sampling\_percentage](#input\_sampling\_percentage) | Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. | `number` | `100` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Specifies the id of a log analytics workspace resource. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | App id of the Application Insights associated to the App Service |
| <a name="output_application_type"></a> [application\_type](#output\_application\_type) | Application Type of the Application Insights associated to the App Service |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The Connection String for this Application Insights component |
| <a name="output_id"></a> [id](#output\_id) | Id of the Application Insights associated to the App Service |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | Instrumentation key of the Application Insights associated to the App Service |
| <a name="output_name"></a> [name](#output\_name) | Name of the Application Insights associated to the App Service |
<!-- END_TF_DOCS -->