<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Optional) Azure Location | `string` | `"uaenorth"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | (Mandatory) Name of the resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Resource Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rg_location"></a> [rg\_location](#output\_rg\_location) | Location of the resource group |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Name of the resource group |
<!-- END_TF_DOCS -->