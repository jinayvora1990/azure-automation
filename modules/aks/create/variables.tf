variable "location" {
  type        = string
  description = "location of key vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of AKS"
}

variable "environment" {
  type        = string
  description = "The name of the environment that the cluster will be a part of. Eg: dev, qa, uat, sit, prod"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
  default     = ""
}

variable "aks_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet to use for AKS Default Node Pool"
}

variable "aks_name_suffix" {
  type        = string
  description = "Azure Kubernetes Service (AKS) name suffix"
  default     = "aks"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.aks_name_suffix))
    error_message = "AKS name suffix has to be combination of lowercase letter or number."
  }
}

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  default     = "1.29.2"
  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.kubernetes_version)) || var.kubernetes_version == ""
    error_message = "Kubernetes version must meet semantic versioning format."
  }
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`."
  default     = null
  validation {
    condition     = var.automatic_channel_upgrade == null ? true : contains(["patch", "rapid", "node-image", "stable"], var.automatic_channel_upgrade)
    error_message = "AKS channel version must be one of those values: `patch`, `rapid`, `node-image` and `stable`."
  }
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster"
  default     = "Free"
  validation {
    condition     = can(regex("^(Free|Standard)$", var.aks_sku_tier))
    error_message = "Allowed values: Free, Standard."
  }
}

variable "availability_zones" {
  type        = list(number)
  description = "Availability zones in which nodes are placed"
  default     = [1, 2, 3]
}

variable "aks_vm_size" {
  type        = string
  description = "Azure Kubernetes Service (AKS) VMs size"
  default     = "Standard_DS2_v2"
  validation {
    condition     = can(regex("^\\w+$", var.aks_vm_size))
    error_message = "AKS VMs size is not valid."
  }
}

variable "aks_network_plugin" {
  type        = string
  description = "Azure Kubernetes Service (AKS) network plugin"
  default     = "kubenet"
  validation {
    condition     = can(regex("^(azure|kubenet)$", var.aks_network_plugin))
    error_message = "AKS network plugin name is not valid."
  }
}

variable "aks_enable_auto_scaling" {
  description = "The value of 'enable_auto_scaling' flag on the AKS cluster"
  type        = bool
  default     = true
}

variable "aks_agent_count" {
  type        = number
  description = "Number of workers in the agent pool"
  default     = 1
}

variable "aks_default_node_pool_name" {
  type        = string
  default     = "default"
  description = "The AKS default node pool name"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.aks_default_node_pool_name))
    error_message = "AKS default node pool name has to be combination of lowercase letter or number."
  }
}

variable "node_resource_group_name" {
  type        = string
  description = "Node resource group name, if not specified follows format 'MC_<resourcegroupname>_<clustername>_<location>'"
  default     = ""
  validation {
    condition     = can(regex("^[A-z0-9-_]*$", var.node_resource_group_name))
    error_message = "Node resource group name has to be combination of letters, numbers, dashes or underscores."
  }
}

variable "aks_node_count_min" {
  type        = number
  description = "Min number of nodes in the agent pool"
  default     = 1
}

variable "aks_node_count_max" {
  type        = number
  description = "Max number of nodes in the agent pool"
  default     = 10
}

variable "aks_node_max_pods" {
  type        = number
  description = "Number of pods per node"
  default     = 30
}

variable "aks_os_disk_type" {
  type        = string
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed."
  default     = "Managed"
  validation {
    condition     = can(regex("^(Ephemeral|Managed)$", var.aks_os_disk_type))
    error_message = "The value of aks_os_disk_type has to be either Ephemeral or Managed."
  }
}

variable "aks_node_os_disk_size_gb" {
  type        = number
  description = "The size of the OS Disk which should be used for each agent in the Node Pool"
  default     = 100
}

variable "aks_node_ultra_ssd_enabled" {
  type        = bool
  description = "Used to specify whether the UltraSSD is enabled in the Node Pool"
  default     = false
}

variable "only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) adds the follow Node taint for default node pool - CriticalAddonsOnly=true:NoSchedule"
  default     = false
}

variable "max_surge" {
  type        = string
  description = "(Required) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade."
  default     = "30"
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = list(number)
    }))
    not_allowed = list(object({
      start = string
      end   = string
    }))
  })
  description = "Maintenance window configuration"
  default     = null

  validation {
    condition     = var.maintenance_window == null ? true : alltrue([for allowed in var.maintenance_window.allowed : contains(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], allowed.day)])
    error_message = "Incorrect day value. Allowed values are `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` and `Saturday`."
  }

  validation {
    condition     = var.maintenance_window == null ? true : alltrue([for allowed in var.maintenance_window.allowed : alltrue([for h in allowed.hours : h >= 0 && h <= 23])])
    error_message = "Incorrect hour value. Possible values are between 0 and 23."
  }
}

variable "enable_kubelet_identity" {
  type        = bool
  default     = true
  description = "(optional) Enable creation the kubelet identity in the AKS resource group instead of node resource group"
}

variable "oms_agent_log_analytics_workspace_id" {
  type        = string
  description = "(Optional) Enable OMS Agent and send logs to Log Analytics Workspace"
  default     = ""
}

variable "workload_identity_enabled" {
  type        = bool
  description = "(optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster"
  default     = false
}

variable "oidc_issuer_enabled" {
  type        = bool
  description = "Enable or Disable the OIDC issuer URL"
  default     = false
}

variable "admin_username" {
  type        = string
  description = "The Linux profile admin username"
  default     = "azureuser"
}

variable "enable_azure_key_vault_secrets_provider" {
  type        = bool
  default     = false
  description = "(optional) Enable Azure Key Vault secrets provider"
}

variable "enable_azure_key_vaults_secrets_rotation" {
  type        = bool
  default     = false
  description = "(optional) Enable Azure Key Vault secret rotation"
}

variable "azure_key_vaults_secrets_rotation_interval" {
  type        = string
  default     = "2m"
  description = "(optional) Azure Key Vault secret rotation interval"
}

variable "azure_active_directory_managed" {
  type        = bool
  description = "Enable AKS managed AAD integration, https://docs.microsoft.com/en-gb/azure/aks/managed-aad"
  default     = true
}

variable "azure_active_directory_admin_group_object_ids" {
  type        = list(string)
  default     = []
  description = "(optional) A list of Object IDs of Azure Active Directory Groups which should have Cluster Admin Role on the Cluster. Used only when azure_active_directory_managed is set to true."
}

variable "azure_active_directory_rbac_enabled" {
  type        = bool
  description = "Enable AKS managed Azure RBAC integration, https://docs.microsoft.com/en-us/azure/aks/manage-azure-rbac"
  default     = false
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "Authorized IP ranges to access k8s API"
  default     = []
}

variable "regular_node_pools" {
  type = list(object({
    name                = string
    os_disk_type        = string
    os_disk_size_gb     = number
    vm_size             = string
    max_count           = number
    min_count           = number
    node_count          = number
    max_pods            = number
    availability_zones  = list(number)
    enable_auto_scaling = bool
    node_taints         = list(string)
    mode                = string
    node_labels         = map(string)
    kubernetes_version  = string
    ultra_ssd_enabled   = bool
  }))
  description = "User-defined node pools of Regular priority"
  default     = []

  validation {
    condition = alltrue([
      for pool in var.regular_node_pools :
      can(regex("^\\w+$", pool.vm_size)) &&
      can(regex("^[a-z0-9]+$", pool.name)) &&
      can(regex("^(System|User)$", pool.mode)) &&
      (pool.os_disk_type == null || can(regex("^(Ephemeral|Managed)$", pool.os_disk_type)))
    ])
    error_message = "Some of regular_node_pools is invalid."
  }
}

variable "enable_private_cluster" {
  type        = bool
  description = "Enable private Kubernetes cluster. Changing this forces a new resource to be created."
  default     = false
}

variable "enable_private_cluster_public_fqdn" {
  type        = bool
  description = "Enable private Kubernetes cluster public fqdn."
  default     = false
}

variable "aks_private_dns_zone_id" {
  type        = string
  description = "(optional) Private DNS Zone configuration. Accepts `System` for AKS Managed Private Zone (Default), `None` doesn't create any zone, or ID of existing Private DNS Zone in this domain format `privatelink.<REGION>.azmk8s.io`."
  default     = null
}

variable "aks_private_dns_zone_role_assignment" {
  type        = bool
  description = "Assign permissions to custom DNS private zone provided by `aks_private_dns_zone_id`."
  default     = false
}

variable "create_private_dns_zone" {
  type        = bool
  description = "(optional) Create Private DNS Zone for private cluster. `aks_private_dns_zone_id` variable takes precedence."
  default     = false
}

variable "enable_azure_policy" {
  type        = bool
  description = "(optional) Enable Azure Policy for Kubernetes Add On"
  default     = false
}

variable "enable_local_account" {
  type        = bool
  description = "If true local accounts will be enabled. Defaults to true."
  default     = false
}

variable "aks_pod_cidr" {
  type        = string
  description = "CIDR allocated for Kubernetes Pods (only used when aks_network_plugin is set to 'kubenet')"
  default     = "10.117.0.0/20"
}

variable "aks_service_cidr" {
  description = "CIDR allocated for Kubernetes Services"
  type        = string
  default     = "10.117.17.0/24"
  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", var.aks_service_cidr))
    error_message = "CIDR for Kubernetes Services is not valid."
  }
}

variable "aks_dns_ip" {
  description = "Kubernetes DNS service IP"
  type        = string
  default     = "10.117.17.10"
  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$", var.aks_dns_ip))
    error_message = "Kubernetes DNS service IP is not valid."
  }
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
DESCRIPTION
  nullable    = false

  validation {
    condition     = alltrue([for _, v in var.diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
  validation {
    condition = alltrue(
      [
        for _, v in var.diagnostic_settings :
        v.workspace_resource_id != null || v.storage_account_resource_id != null || v.event_hub_authorization_rule_resource_id != null || v.marketplace_partner_resource_id != null
      ]
    )
    error_message = "At least one of `workspace_resource_id`, `storage_account_resource_id`, `marketplace_partner_resource_id`, or `event_hub_authorization_rule_resource_id`, must be set."
  }
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}

variable "acr" {
  type = list(object({
    name           = string
    resource_group = string
  }))
  description = "Configure Kubelet identity to pull images from these Azure Container Registries"
  default     = []
}
