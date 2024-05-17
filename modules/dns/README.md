<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.102.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.pvt_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The name of the private dns zone | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Existing resource group | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The virtual network name which contains the pep for the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone_name"></a> [dns\_zone\_name](#output\_dns\_zone\_name) | n/a |
<!-- END_TF_DOCS -->