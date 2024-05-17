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
| [azurerm_key_vault_key.encryption_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_recovery_services_vault.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_role_assignment.crypto_encryption_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.rsv_managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | n/a | yes |
| <a name="input_classic_vmware_replication_enabled"></a> [classic\_vmware\_replication\_enabled](#input\_classic\_vmware\_replication\_enabled) | Enable the Classic experience for VMware replication. | `bool` | `false` | no |
| <a name="input_cross_region_restore_enabled"></a> [cross\_region\_restore\_enabled](#input\_cross\_region\_restore\_enabled) | Is cross region restore enabled for this Vault? | `bool` | `false` | no |
| <a name="input_encryption_config"></a> [encryption\_config](#input\_encryption\_config) | Encryption details for the vault | <pre>object({<br>    infrastructure_encryption = bool<br>    encryption_key = object({<br>      vault = object({<br>        key_vault_name      = string<br>        resource_group_name = string<br>      })<br>      rotation_policy = optional(object({<br>        expire_after         = string<br>        notify_before_expiry = string<br>        time_before_expiry   = string<br>      }))<br>    })<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where redis cache is provisioned | `string` | n/a | yes |
| <a name="input_immutability"></a> [immutability](#input\_immutability) | Immutability settings of vault. possible values - `Locked`, `Unlocked` and `Disabled` | `string` | `"Unlocked"` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | Monitoring configuration for the vault | <pre>object({<br>    alerts_for_all_job_failures            = optional(bool)<br>    alerts_for_critical_operation_failures = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the recovery services vault | `string` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | Region for the recovery services vault | `string` | `"uaenorth"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Sets the vault's SKU. Possible values include: Standard, RS0 | `string` | `"Standard"` | no |
| <a name="input_soft_delete"></a> [soft\_delete](#input\_soft\_delete) | Status of soft delete for the backup vault | `string` | `"on"` | no |
| <a name="input_storage_mode_type"></a> [storage\_mode\_type](#input\_storage\_mode\_type) | The storage type of the Recovery Services Vault. Possible values - `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant` | `string` | `"GeoRedundant"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_encryption_key"></a> [encryption\_key](#output\_encryption\_key) | The name of the encryption key for the recovery services vault |
| <a name="output_vault_id"></a> [vault\_id](#output\_vault\_id) | The id of the azure backup vault |
| <a name="output_vault_name"></a> [vault\_name](#output\_vault\_name) | The name of the azure recovery services vault |
<!-- END_TF_DOCS -->