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
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_role_assignment.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_contributors"></a> [contributors](#input\_contributors) | A list of users / apps that should have Log Analytics Contributer access. Required to use log analytics as log source. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to provision resources | `string` | n/a | yes |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Specifies if the Log Analytics Workspace should enforce authentication using Azure AD. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the backup vault | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | Region for the backup vault | `string` | `"uaenorth"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days that logs should be retained. | `number` | `90` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018. | `string` | `"PerGB2018"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_law_id"></a> [law\_id](#output\_law\_id) | The ID of this Log Analytics workspace. |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The primary shared key of this Log Analytics workspace. |
| <a name="output_secondary_shared_key"></a> [secondary\_shared\_key](#output\_secondary\_shared\_key) | The secondary shared key of this Log Analytics workspace. |
| <a name="output_workspace_customer_id"></a> [workspace\_customer\_id](#output\_workspace\_customer\_id) | The workspace (customer) ID of this Log Analytics workspace. |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of this Log Analytics workspace. |
<!-- END_TF_DOCS -->