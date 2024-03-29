variable "location" {
  type        = string
  description = "The location/region where the resource is created e.g. uaenorth. Changing this forces a new resource to be created."
  default     = "uaenorth"
}

variable "resource_group" {
  type        = string
  description = "Existing resource group"
  default     = null
}

variable "environment" {
  type        = string
  description = "The name of the environment that the cluster will be a part of. Eg: dev, qa, uat, sit, prod"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}

variable "virtual_network_name" {
  type        = string
  default     = null
  description = "Name of virtual network. You must also provide virtual_network_resource_group"
}

variable "virtual_network_resource_group" {
  type        = string
  default     = null
  description = "Name of virtual network resource group"
}

variable "subnet" {
  type = object({
    name           = string
    vnet           = string
    resource_group = string
  })
  description = "Subnet to use with PostgreSQL server"
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