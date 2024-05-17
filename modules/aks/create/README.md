<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.100.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.101.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.regular_node_pools](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_role_assignment.acr_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.custom_private_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kubelet_identity_role_assignment_managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.private_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.kubelet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [tls_private_key.pair](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr"></a> [acr](#input\_acr) | Configure Kubelet identity to pull images from these Azure Container Registries | <pre>list(object({<br>    name           = string<br>    resource_group = string<br>  }))</pre> | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The Linux profile admin username | `string` | `"azureuser"` | no |
| <a name="input_aks_agent_count"></a> [aks\_agent\_count](#input\_aks\_agent\_count) | Number of workers in the agent pool | `number` | `1` | no |
| <a name="input_aks_default_node_pool_name"></a> [aks\_default\_node\_pool\_name](#input\_aks\_default\_node\_pool\_name) | The AKS default node pool name | `string` | `"default"` | no |
| <a name="input_aks_dns_ip"></a> [aks\_dns\_ip](#input\_aks\_dns\_ip) | Kubernetes DNS service IP | `string` | `"10.117.17.10"` | no |
| <a name="input_aks_enable_auto_scaling"></a> [aks\_enable\_auto\_scaling](#input\_aks\_enable\_auto\_scaling) | The value of 'enable\_auto\_scaling' flag on the AKS cluster | `bool` | `true` | no |
| <a name="input_aks_name_suffix"></a> [aks\_name\_suffix](#input\_aks\_name\_suffix) | Azure Kubernetes Service (AKS) name suffix | `string` | `"aks"` | no |
| <a name="input_aks_network_plugin"></a> [aks\_network\_plugin](#input\_aks\_network\_plugin) | Azure Kubernetes Service (AKS) network plugin | `string` | `"kubenet"` | no |
| <a name="input_aks_node_count_max"></a> [aks\_node\_count\_max](#input\_aks\_node\_count\_max) | Max number of nodes in the agent pool | `number` | `10` | no |
| <a name="input_aks_node_count_min"></a> [aks\_node\_count\_min](#input\_aks\_node\_count\_min) | Min number of nodes in the agent pool | `number` | `1` | no |
| <a name="input_aks_node_max_pods"></a> [aks\_node\_max\_pods](#input\_aks\_node\_max\_pods) | Number of pods per node | `number` | `30` | no |
| <a name="input_aks_node_os_disk_size_gb"></a> [aks\_node\_os\_disk\_size\_gb](#input\_aks\_node\_os\_disk\_size\_gb) | The size of the OS Disk which should be used for each agent in the Node Pool | `number` | `100` | no |
| <a name="input_aks_node_ultra_ssd_enabled"></a> [aks\_node\_ultra\_ssd\_enabled](#input\_aks\_node\_ultra\_ssd\_enabled) | Used to specify whether the UltraSSD is enabled in the Node Pool | `bool` | `false` | no |
| <a name="input_aks_os_disk_type"></a> [aks\_os\_disk\_type](#input\_aks\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. | `string` | `"Managed"` | no |
| <a name="input_aks_pod_cidr"></a> [aks\_pod\_cidr](#input\_aks\_pod\_cidr) | CIDR allocated for Kubernetes Pods (only used when aks\_network\_plugin is set to 'kubenet') | `string` | `"10.117.0.0/20"` | no |
| <a name="input_aks_private_dns_zone_id"></a> [aks\_private\_dns\_zone\_id](#input\_aks\_private\_dns\_zone\_id) | (optional) Private DNS Zone configuration. Accepts `System` for AKS Managed Private Zone (Default), `None` doesn't create any zone, or ID of existing Private DNS Zone in this domain format `privatelink.<REGION>.azmk8s.io`. | `string` | `null` | no |
| <a name="input_aks_private_dns_zone_role_assignment"></a> [aks\_private\_dns\_zone\_role\_assignment](#input\_aks\_private\_dns\_zone\_role\_assignment) | Assign permissions to custom DNS private zone provided by `aks_private_dns_zone_id`. | `bool` | `false` | no |
| <a name="input_aks_service_cidr"></a> [aks\_service\_cidr](#input\_aks\_service\_cidr) | CIDR allocated for Kubernetes Services | `string` | `"10.117.17.0/24"` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster | `string` | `"Free"` | no |
| <a name="input_aks_subnet"></a> [aks\_subnet](#input\_aks\_subnet) | Subnet to use for AKS Default Node Pool | <pre>object({<br>    name           = string<br>    vnet_name      = string<br>    resource_group = string<br>  })</pre> | n/a | yes |
| <a name="input_aks_vm_size"></a> [aks\_vm\_size](#input\_aks\_vm\_size) | Azure Kubernetes Service (AKS) VMs size | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | Authorized IP ranges to access k8s API | `list(string)` | `[]` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application that requires this resource | `string` | `""` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. | `string` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones in which nodes are placed | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_azure_active_directory_admin_group_object_ids"></a> [azure\_active\_directory\_admin\_group\_object\_ids](#input\_azure\_active\_directory\_admin\_group\_object\_ids) | (optional) A list of Object IDs of Azure Active Directory Groups which should have Cluster Admin Role on the Cluster. Used only when azure\_active\_directory\_managed is set to true. | `list(string)` | `[]` | no |
| <a name="input_azure_active_directory_managed"></a> [azure\_active\_directory\_managed](#input\_azure\_active\_directory\_managed) | Enable AKS managed AAD integration, https://docs.microsoft.com/en-gb/azure/aks/managed-aad | `bool` | `true` | no |
| <a name="input_azure_active_directory_rbac_enabled"></a> [azure\_active\_directory\_rbac\_enabled](#input\_azure\_active\_directory\_rbac\_enabled) | Enable AKS managed Azure RBAC integration, https://docs.microsoft.com/en-us/azure/aks/manage-azure-rbac | `bool` | `false` | no |
| <a name="input_azure_key_vaults_secrets_rotation_interval"></a> [azure\_key\_vaults\_secrets\_rotation\_interval](#input\_azure\_key\_vaults\_secrets\_rotation\_interval) | (optional) Azure Key Vault secret rotation interval | `string` | `"2m"` | no |
| <a name="input_create_private_dns_zone"></a> [create\_private\_dns\_zone](#input\_create\_private\_dns\_zone) | (optional) Create Private DNS Zone for private cluster. `aks_private_dns_zone_id` variable takes precedence. | `bool` | `false` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br><br>- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.<br>- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.<br>- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.<br>- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.<br>- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.<br>- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.<br>- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.<br>- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.<br>- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs. | <pre>map(object({<br>    name                                     = optional(string, null)<br>    log_categories                           = optional(set(string), [])<br>    metric_categories                        = optional(set(string), ["AllMetrics"])<br>    log_analytics_destination_type           = optional(string, "Dedicated")<br>    workspace_resource_id                    = optional(string, null)<br>    storage_account_resource_id              = optional(string, null)<br>    event_hub_authorization_rule_resource_id = optional(string, null)<br>    event_hub_name                           = optional(string, null)<br>    marketplace_partner_resource_id          = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_enable_azure_key_vault_secrets_provider"></a> [enable\_azure\_key\_vault\_secrets\_provider](#input\_enable\_azure\_key\_vault\_secrets\_provider) | (optional) Enable Azure Key Vault secrets provider | `bool` | `false` | no |
| <a name="input_enable_azure_key_vaults_secrets_rotation"></a> [enable\_azure\_key\_vaults\_secrets\_rotation](#input\_enable\_azure\_key\_vaults\_secrets\_rotation) | (optional) Enable Azure Key Vault secret rotation | `bool` | `false` | no |
| <a name="input_enable_azure_policy"></a> [enable\_azure\_policy](#input\_enable\_azure\_policy) | (optional) Enable Azure Policy for Kubernetes Add On | `bool` | `false` | no |
| <a name="input_enable_kubelet_identity"></a> [enable\_kubelet\_identity](#input\_enable\_kubelet\_identity) | (optional) Enable creation the kubelet identity in the AKS resource group instead of node resource group | `bool` | `true` | no |
| <a name="input_enable_local_account"></a> [enable\_local\_account](#input\_enable\_local\_account) | If true local accounts will be enabled. Defaults to true. | `bool` | `false` | no |
| <a name="input_enable_private_cluster"></a> [enable\_private\_cluster](#input\_enable\_private\_cluster) | Enable private Kubernetes cluster. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_enable_private_cluster_public_fqdn"></a> [enable\_private\_cluster\_public\_fqdn](#input\_enable\_private\_cluster\_public\_fqdn) | Enable private Kubernetes cluster public fqdn. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment that the cluster will be a part of. Eg: dev, qa, uat, sit, prod | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes specified when creating the AKS managed cluster | `string` | `"1.29.2"` | no |
| <a name="input_location"></a> [location](#input\_location) | location of key vault | `string` | `"uaenorth"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration | <pre>object({<br>    allowed = list(object({<br>      day   = string<br>      hours = list(number)<br>    }))<br>    not_allowed = list(object({<br>      start = string<br>      end   = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_max_surge"></a> [max\_surge](#input\_max\_surge) | (Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. | `string` | `"30"` | no |
| <a name="input_node_resource_group_name"></a> [node\_resource\_group\_name](#input\_node\_resource\_group\_name) | Node resource group name, if not specified follows format 'MC\_<resourcegroupname>\_<clustername>\_<location>' | `string` | `""` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | Enable or Disable the OIDC issuer URL | `bool` | `false` | no |
| <a name="input_oms_agent_log_analytics_workspace_id"></a> [oms\_agent\_log\_analytics\_workspace\_id](#input\_oms\_agent\_log\_analytics\_workspace\_id) | (Optional) Enable OMS Agent and send logs to Log Analytics Workspace | `string` | `""` | no |
| <a name="input_only_critical_addons_enabled"></a> [only\_critical\_addons\_enabled](#input\_only\_critical\_addons\_enabled) | (Optional) adds the follow Node taint for default node pool - CriticalAddonsOnly=true:NoSchedule | `bool` | `false` | no |
| <a name="input_regular_node_pools"></a> [regular\_node\_pools](#input\_regular\_node\_pools) | User-defined node pools of Regular priority | <pre>list(object({<br>    name                = string<br>    os_disk_type        = string<br>    os_disk_size_gb     = number<br>    vm_size             = string<br>    max_count           = number<br>    min_count           = number<br>    node_count          = number<br>    max_pods            = number<br>    availability_zones  = list(number)<br>    enable_auto_scaling = bool<br>    node_taints         = list(string)<br>    mode                = string<br>    node_labels         = map(string)<br>    kubernetes_version  = string<br>    ultra_ssd_enabled   = bool<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of AKS | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | User defined extra tags to be added to all resources created in the module | `map(string)` | `{}` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | (optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_client_certificate"></a> [aks\_client\_certificate](#output\_aks\_client\_certificate) | n/a |
| <a name="output_aks_client_key"></a> [aks\_client\_key](#output\_aks\_client\_key) | n/a |
| <a name="output_aks_cluster_ca_certificate"></a> [aks\_cluster\_ca\_certificate](#output\_aks\_cluster\_ca\_certificate) | n/a |
| <a name="output_aks_cluster_id"></a> [aks\_cluster\_id](#output\_aks\_cluster\_id) | n/a |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | n/a |
| <a name="output_aks_network_plugin"></a> [aks\_network\_plugin](#output\_aks\_network\_plugin) | n/a |
| <a name="output_aks_node_resource_group"></a> [aks\_node\_resource\_group](#output\_aks\_node\_resource\_group) | n/a |
| <a name="output_aks_oidc_issuer_url"></a> [aks\_oidc\_issuer\_url](#output\_aks\_oidc\_issuer\_url) | n/a |
| <a name="output_aks_oms_agent_identity_object_id"></a> [aks\_oms\_agent\_identity\_object\_id](#output\_aks\_oms\_agent\_identity\_object\_id) | n/a |
| <a name="output_aks_portal_fqdn"></a> [aks\_portal\_fqdn](#output\_aks\_portal\_fqdn) | n/a |
| <a name="output_aks_private_fqdn"></a> [aks\_private\_fqdn](#output\_aks\_private\_fqdn) | n/a |
| <a name="output_aks_public_fqdn"></a> [aks\_public\_fqdn](#output\_aks\_public\_fqdn) | n/a |
| <a name="output_aks_user_assigned_identity_id"></a> [aks\_user\_assigned\_identity\_id](#output\_aks\_user\_assigned\_identity\_id) | n/a |
<!-- END_TF_DOCS -->