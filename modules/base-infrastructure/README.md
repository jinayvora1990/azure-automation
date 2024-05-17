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
| [azurerm_management_group_subscription_association.subscription_mgmtgrp_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_network_ddos_protection_plan.ddos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher.nwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_route_table.udr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg-assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.rt-assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.peer-avd-to-Hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_management_group.mgmt_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application | `string` | n/a | yes |
| <a name="input_azure_mgmt_group"></a> [azure\_mgmt\_group](#input\_azure\_mgmt\_group) | Name of the Management Group where application subscription needs to be associated | `string` | `null` | no |
| <a name="input_create_ddos_plan"></a> [create\_ddos\_plan](#input\_create\_ddos\_plan) | Create an ddos plan - Default is false | `bool` | `false` | no |
| <a name="input_create_network_watcher"></a> [create\_network\_watcher](#input\_create\_network\_watcher) | Controls if Network Watcher resources should be created for the Azure subscription | `bool` | `false` | no |
| <a name="input_ddos_plan_name"></a> [ddos\_plan\_name](#input\_ddos\_plan\_name) | The name of AzureNetwork DDoS Protection Plan | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of dns servers to use for virtual network | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Application Environment | `string` | n/a | yes |
| <a name="input_hub_vnet_id"></a> [hub\_vnet\_id](#input\_hub\_vnet\_id) | Remote Hub VNET ID | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `"uaenorth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group to host base resources | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnets to be created | <pre>map(object({<br>    subnet_name                                   = string<br>    subnet_address_prefix                         = list(string)<br>    service_endpoints                             = optional(list(string))<br>    service_endpoint_policy_ids                   = optional(list(string))<br>    private_endpoint_network_policies_enabled     = optional(bool)<br>    private_link_service_network_policies_enabled = optional(bool)<br>    nsg_inbound_rules                             = optional(list(list(string)), [])<br>    nsg_outbound_rules                            = optional(list(list(string)), [])<br>    route_table_rules                             = optional(list(list(string)), [])<br><br>    delegation = optional(object({<br>      name = string<br>      service_delegation = object({<br>        name    = string<br>        actions = optional(list(string), [])<br>      })<br>    }))<br><br>  }))</pre> | `{}` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID of the Application Subscription. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vnet_address_spaces"></a> [vnet\_address\_spaces](#input\_vnet\_address\_spaces) | The address space to be used for the Azure virtual network. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | Name of the Virtual Network |
<!-- END_TF_DOCS -->