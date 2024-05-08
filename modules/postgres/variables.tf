variable "location" {
  type        = string
  description = "The location/region where the resource is created e.g. uaenorth. Changing this forces a new resource to be created."
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the Postgres DB"
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
}

variable "psql_subnet" {
  type = object({
    name           = string
    vnet_name      = string
    resource_group = string
  })
  description = "Subnet to use with PostgreSQL server"
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

variable "create_mode" {
  type        = string
  default     = "Default"
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, Replica and Update. Support for PointInTimeRestore will be added later"
  validation {
    condition     = can(regex("^(?:Default|Update|Replica)$", var.create_mode))
    error_message = "Allowed values for availability zone: Default, Replica, Update"
  }
}

variable "availability_zone" {
  type        = string
  description = "The Availability Zone of the PostgreSQL Flexible Server. Possible values are 1, 2 and 3"
  default     = "1"
  validation {
    condition     = can(regex("^(?:1|2|3)$", var.availability_zone))
    error_message = "Allowed values for availability zone: 1, 2 or 3."
  }
}

variable "standby_availability_zone" {
  type        = string
  description = "The Availability Zone of the standby Flexible Server. Possible values are 1, 2 and 3."
  default     = "2"
  validation {
    condition     = can(regex("^(?:1|2|3)$", var.standby_availability_zone))
    error_message = "Allowed values for standby availability zone: 1, 2 or 3."
  }
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL flexible Server. The name of the SKU, follows the tier + family + cores pattern (e.g. D2s_v3, D2ds_v4). For available skus run `az postgres flexible-server list-skus --location=LOCATION`"
}

variable "sql_version" {
  type        = string
  description = "Specifies the version of PostgreSQL to use. Valid values are 11, 12, 13, 14, 15, 16"
  default     = "11"
  validation {
    condition     = can(regex("^(?:11|12|13|14|15|16)$", var.sql_version))
    error_message = "Allowed values: 11, 12, 13, 14, 15, 16"
  }
}

variable "storage_in_mb" {
  type        = string
  description = "Max storage allowed for a server (5120 - 4194304)"
  default     = "262144"
  validation {
    condition     = can(regex("^(?:32768|65536|131072|262144|524288|1048576|2097152|4194304|8388608|16777216|33554432)$", var.storage_in_mb))
    error_message = "Allowed values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216 and 33554432. Mb."
  }
}

variable "storage_tier" {
  type        = string
  description = "The name of storage performance tier for IOPS of the PostgreSQL Flexible Server. Possible values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70 or P80. Default value is dependant on the storage_mb value"
  default     = null
  validation {
    condition     = can(regex("^(?:P4|P6|P10|P15|P20|P30|P40|P50|P60|P70|P80)$", var.storage_tier))
    error_message = "Allowed values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70 or P80"
  }
}

variable "high_availability_enabled" {
  type        = bool
  description = "is high availability enabled for azure postgresql flexible server"
  default     = false
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Is geo-redundant backup enabled."
  default     = false
}

variable "maintenance_window" {
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  description = "Maintenance window configuration"
  default     = null

  validation {
    condition     = var.maintenance_window == null ? true : var.maintenance_window.day_of_week >= 0 && var.maintenance_window.day_of_week <= 6
    error_message = "Incorrect day_of_week value. Allowed values are in range of <0,6>. Where 0 represents Sunday, 1 represents Monday..."
  }
  validation {
    condition     = var.maintenance_window == null ? true : var.maintenance_window.start_hour >= 0 && var.maintenance_window.start_hour <= 23
    error_message = "Incorrect start_hour value. Allowed values are in range of <0,23>."
  }
  validation {
    condition     = var.maintenance_window == null ? true : var.maintenance_window.start_minute >= 0 && var.maintenance_window.start_minute <= 59
    error_message = "Incorrect start_minute value. Allowed values are in range of <0,59>."
  }
}

variable "server_configuration" {
  type = map(object({
    config_value = string
  }))
  description = "map for additional server configurations. See https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-server-parameters"
  default     = {}
}

variable "additional_pgbouncer_settings" {
  type = map(object({
    config_value = string
  }))
  description = "map for additional pgbouncer settings. Remember to set `pgbouncer.enabled` to true in server_configuration"
  default     = {}
}

variable "keyvault" {
  type = object({
    name                        = string
    resource_group              = string
    postgres_admin_username_key = string
    postgres_admin_password_key = string
  })
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
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