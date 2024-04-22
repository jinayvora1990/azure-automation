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
| [azurerm_service_plan.sp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment where redis cache is provisioned | `string` | `"dev"` | no |
| <a name="input_max_elastic_worker_count"></a> [max\_elastic\_worker\_count](#input\_max\_elastic\_worker\_count) | The maximum number of workers to use in an Elastic SKU Plan | `number` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type for the service plan | `string` | `"Linux"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the redis cache | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | location of the redis cache | `string` | `"uaenorth"` | no |
| <a name="input_service_plan_sku"></a> [service\_plan\_sku](#input\_service\_plan\_sku) | The SKU for the plan | `string` | `"B1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of Workers (instances) to be allocated | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_kind"></a> [kind](#output\_kind) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | n/a |
