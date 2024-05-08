variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
}

variable "environment" {
  type        = string
  description = "Environment where redis cache is provisioned"
  default     = "dev"
}

variable "cache_tier" {
  type = object({
    family   = string
    capacity = number
    sku_name = string
  })
  description = "This is the tier of the cache that is provisioned"
}

variable "min_tls_version" {
  type        = string
  description = "Minimum TLS version to be used with redis cache"
  default     = "1.2"
}

variable "replicas" {
  type        = number
  description = "The number of replicas of the primary"
  default     = 1
}

variable "cache_eviction_policy" {
  type        = string
  description = "Redis cache key eviction policy"
  default     = "volatile-lru"
}

variable "rdb_backup_enabled" {
  type        = bool
  description = "RDB backup enabled"
  default     = false
}

variable "aof_backup_enabled" {
  type        = bool
  description = "AOF backup enabled"
  default     = false
}

variable "rdb_backup_configuration" {
  type = object({
    backup_frequency          = number
    max_snapshot_count        = number
    storage_connection_string = string
  })
  description = "RDB Backup Configuration"
  default = {
    backup_frequency          = 0
    max_snapshot_count        = 0
    storage_connection_string = ""
  }
}

variable "rdb_storage_account" {
  type = object({
    storage_account_name = string,
    resource_group_name  = string
  })
  default     = null
  description = "Storage Account details to store rdb backups."
}

variable "aof_storage_account" {
  type = object({
    storage_account_name = string,
    resource_group_name  = string
  })
  default     = null
  description = "Storage Account details to store aof backups."
}

variable "shard_count" {
  type        = number
  description = "The number of shards in the redis cache"
  default     = 1
}

variable "redis_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet where the redis cache is provisioned. This subnet needs to have only the redis in the subnet."
  default     = null
}

variable "privatelink_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet where the private link is required."
  default     = null
}

variable "private_dns_zone_name" {
  type        = string
  description = "Name of the private dns zone for private link"
  default     = null
}

variable "patch_schedules" {
  type = list(object({
    day_of_week    = string
    start_hour_utc = number
  }))
  description = "Maintenance schedule of the redis cache."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default     = {}
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
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
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
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

# variable "zones" {
#   type        = set(string)
#   description = "List of Availability zones where redis cache is hosted"
#   default     = []
# }