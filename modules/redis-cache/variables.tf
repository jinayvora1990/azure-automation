variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "redis_cache_name" {
  type        = string
  description = "The name of the redis cache resource created"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
  default     = ""
}
variable "env" {
  type        = string
  description = "Environment where redis cache is provisioned"
  default     = "dev"
}
variable "instance_number" {
  type        = number
  description = "The numeric id of the resource being provisioned"
  default     = 1
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
  description = "RDB backup ennabled"
  default     = false
}

variable "aof_backup_enabled" {
  type        = bool
  description = "AOF backup ennabled"
  default     = false
}

variable "rdb_backup_configuration" {
  type = object({
    backup_frequency          = number
    max_snapshot_count        = number
    storage_connection_string = string
  })
  description = "RDB Backup Confifuration"
  default     = {
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

variable "patch_schedules" {
  type = list(object({
    day_of_week    = string
    start_hour_utc = number
  }))
  description = "Maintenance schedule of the redis cache."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default     = {}
}

variable "log_analytics" {
  type = object({
    workspace_name      = string
    resource_group_name = string
  })
  description = "Log Analytics workspace"
  default     = null
}

# variable "zones" {
#   type        = set(string)
#   description = "List of Availability zones where redis cache is hosted"
#   default     = []
# }