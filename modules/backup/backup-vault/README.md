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
| <a name="module_res-id"></a> [res-id](#module\_res-id) | ../../utility/random-identifier | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_backup_vault.backup_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_datastore_type"></a> [datastore\_type](#input\_datastore\_type) | The datastore type of the backup vault. Possible values are `ArchiveStore`, `OperationalStore` and `VaultStore` | `string` | `"VaultStore"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity for the resource | <pre>object({<br>    type = string<br>  })</pre> | `null` | no |
| <a name="input_redundancy"></a> [redundancy](#input\_redundancy) | The backup storage redundancy of the backup vault. Possible values are `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant` | `string` | `"GeoRedundant"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the backup vault | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | Region for the backup vault | `string` | `"uaenorth"` | no |
| <a name="input_retention_duration"></a> [retention\_duration](#input\_retention\_duration) | The soft delete retention duration for the Backup Vault. Possible values are between 14 and 180. | `number` | `14` | no |
| <a name="input_soft_delete"></a> [soft\_delete](#input\_soft\_delete) | Status of soft delete for the backup vault | `string` | `"on"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_vault_id"></a> [backup\_vault\_id](#output\_backup\_vault\_id) | The id of the azure recovery services vault |
| <a name="output_vault_name"></a> [vault\_name](#output\_vault\_name) | The name of the azure recovery services vault |
<!-- END_TF_DOCS -->