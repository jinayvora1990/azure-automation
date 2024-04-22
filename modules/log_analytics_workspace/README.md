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
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_role_assignment.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contributors"></a> [contributors](#input\_contributors) | A list of users / apps that should have Log Analytics Contributer access. Required to use log analytics as log source. | `list(string)` | `[]` | no |
| <a name="input_diagnostic_setting_enabled_log_categories"></a> [diagnostic\_setting\_enabled\_log\_categories](#input\_diagnostic\_setting\_enabled\_log\_categories) | A list of log categories to be enabled for this diagnostic setting. | `list(string)` | <pre>[<br>  "Audit"<br>]</pre> | no |
| <a name="input_diagnostic_setting_enabled_metric_categories"></a> [diagnostic\_setting\_enabled\_metric\_categories](#input\_diagnostic\_setting\_enabled\_metric\_categories) | A list of metric categories to be enabled for this diagnostic setting. | `list(string)` | `[]` | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Specifies if the Log Analytics Workspace should enforce authentication using Azure AD. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days that logs should be retained. | `number` | `90` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | The name of this Log Analytics workspace. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_law_id"></a> [law\_id](#output\_law\_id) | The ID of this Log Analytics workspace. |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The primary shared key of this Log Analytics workspace. |
| <a name="output_secondary_shared_key"></a> [secondary\_shared\_key](#output\_secondary\_shared\_key) | The secondary shared key of this Log Analytics workspace. |
| <a name="output_workspace_customer_id"></a> [workspace\_customer\_id](#output\_workspace\_customer\_id) | The workspace (customer) ID of this Log Analytics workspace. |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of this Log Analytics workspace. |
