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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_res-id"></a> [res-id](#module\_res-id) | ../utility/random-identifier | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.atp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_private_endpoint.blob_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.file_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.queue_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.table_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.storeacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.lcpolicy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_queue.queues](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_share.fileshare](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_table.tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_subnet.privatelink_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | `""` | no |
| <a name="input_blob_soft_delete_retention_days"></a> [blob\_soft\_delete\_retention\_days](#input\_blob\_soft\_delete\_retention\_days) | Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7` | `number` | `7` | no |
| <a name="input_business_divsion"></a> [business\_divsion](#input\_business\_divsion) | Business Division in the large organization this Infrastructure belongs | `string` | `""` | no |
| <a name="input_change_feed_enabled"></a> [change\_feed\_enabled](#input\_change\_feed\_enabled) | Is the blob service properties for change feed events enabled? | `bool` | `false` | no |
| <a name="input_container_soft_delete_retention_days"></a> [container\_soft\_delete\_retention\_days](#input\_container\_soft\_delete\_retention\_days) | Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7` | `number` | `7` | no |
| <a name="input_containers_list"></a> [containers\_list](#input\_containers\_list) | List of containers to create and their access levels. | `list(object({ name = string, access_type = string }))` | `[]` | no |
| <a name="input_enable_advanced_threat_protection"></a> [enable\_advanced\_threat\_protection](#input\_enable\_advanced\_threat\_protection) | Boolean flag which controls if advanced threat protection is enabled. | `bool` | `false` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Is versioning enabled? Default to `false` | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Variable used as a prefix | `string` | `"dev"` | no |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | List of file shares to create and their access levels. | `list(object({ name = string, quota = number }))` | `[]` | no |
| <a name="input_last_access_time_enabled"></a> [last\_access\_time\_enabled](#input\_last\_access\_time\_enabled) | Is the last access time based tracking enabled? Default to `false` | `bool` | `false` | no |
| <a name="input_lifecycles"></a> [lifecycles](#input\_lifecycles) | Configure Azure Storage firewalls and virtual networks | `list(object({ prefix_match = set(string), tier_to_cool_after_days = number, tier_to_archive_after_days = number, delete_after_days = number, snapshot_delete_after_days = number }))` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `"uaenorth"` | no |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine. | `list(string)` | `null` | no |
| <a name="input_managed_identity_type"></a> [managed\_identity\_type](#input\_managed\_identity\_type) | The type of Managed Identity which should be assigned to the Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` | `string` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account | `string` | `"TLS1_2"` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | Network rules restricting access to the storage account. | `object({ bypass = list(string), ip_rules = list(string), subnet_ids = list(string) })` | `null` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | Project owners email address/AAD Group name | `string` | `""` | no |
| <a name="input_privatelink_subnet"></a> [privatelink\_subnet](#input\_privatelink\_subnet) | Subnet where the private link is required. | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | `null` | no |
| <a name="input_queues"></a> [queues](#input\_queues) | List of storages queues | `list(string)` | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | A container that holds related resources for an Azure solution | `string` | n/a | yes |
| <a name="input_skuname"></a> [skuname](#input\_skuname) | The SKUs supported by Microsoft Azure Storage. Valid options are Premium\_LRS, Premium\_ZRS, Standard\_GRS, Standard\_GZRS, Standard\_LRS, Standard\_RAGRS, Standard\_RAGZRS, Standard\_ZRS | `string` | `"Standard_RAGRS"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the azure storage account | `string` | `""` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | List of storage tables. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_containers"></a> [containers](#output\_containers) | Map of containers. |
| <a name="output_file_shares"></a> [file\_shares](#output\_file\_shares) | Map of Storage SMB file shares. |
| <a name="output_queues"></a> [queues](#output\_queues) | Map of Storage SMB file shares. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account. |
| <a name="output_storage_account_primary_blob_endpoint"></a> [storage\_account\_primary\_blob\_endpoint](#output\_storage\_account\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_account_primary_location"></a> [storage\_account\_primary\_location](#output\_storage\_account\_primary\_location) | The primary location of the storage account |
| <a name="output_storage_account_primary_web_endpoint"></a> [storage\_account\_primary\_web\_endpoint](#output\_storage\_account\_primary\_web\_endpoint) | The endpoint URL for web storage in the primary location. |
| <a name="output_storage_account_primary_web_host"></a> [storage\_account\_primary\_web\_host](#output\_storage\_account\_primary\_web\_host) | The hostname with port if applicable for web storage in the primary location. |
| <a name="output_storage_primary_access_key"></a> [storage\_primary\_access\_key](#output\_storage\_primary\_access\_key) | The primary access key for the storage account |
| <a name="output_storage_primary_connection_string"></a> [storage\_primary\_connection\_string](#output\_storage\_primary\_connection\_string) | The primary connection string for the storage account |
| <a name="output_storage_secondary_access_key"></a> [storage\_secondary\_access\_key](#output\_storage\_secondary\_access\_key) | The primary access key for the storage account. |
| <a name="output_tables"></a> [tables](#output\_tables) | Map of Storage SMB file shares. |
<!-- END_TF_DOCS -->