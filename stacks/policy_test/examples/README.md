<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_assignment"></a> [policy\_assignment](#module\_policy\_assignment) | ../../../modules/policy/modules/def_assignment | n/a |
| <a name="module_policy_definition"></a> [policy\_definition](#module\_policy\_definition) | ../../../modules/policy/modules/definition | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy_details"></a> [policy\_details](#input\_policy\_details) | n/a | <pre>map(object({<br>    assignment_effect     = string<br>    assignment_parameters = any<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->