<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.100.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_policy_definition.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display Name to be used for this policy | `string` | `""` | no |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | The filepath to the custom policy. Omitting this assumes the policy is located in the module library | `any` | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Policy definition description | `string` | `""` | no |
| <a name="input_policy_metadata"></a> [policy\_metadata](#input\_policy\_metadata) | The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will fallback to meta in the definition or merge var.policy\_category and var.policy\_version | `any` | `null` | no |
| <a name="input_policy_mode"></a> [policy\_mode](#input\_policy\_mode) | Specify which Resource Provider modes will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.Kubernetes.Data, Microsoft.KeyVault.Data or Microsoft.Network.Data | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy\_category/policy\_name. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_policy_parameters"></a> [policy\_parameters](#input\_policy\_parameters) | Parameters for the policy definition. This field is a JSON object representing the parameters of your policy definition. Omitting this assumes the parameters are located in the policy file | `any` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in the policy file | `any` | `null` | no |
| <a name="input_policy_version"></a> [policy\_version](#input\_policy\_version) | The version for this policy, if different from the one stored in the definition metadata, defaults to 1.0.0 | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition"></a> [definition](#output\_definition) | The combined Policy Definition resource node |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Policy Definition |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | The metadata of the Policy Definition |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Definition |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The parameters of the Policy Definition |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules of the Policy Definition |
<!-- END_TF_DOCS -->