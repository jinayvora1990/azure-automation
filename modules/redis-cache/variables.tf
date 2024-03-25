variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
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

variable "max_memory_policy" {
  type        = string
  description = "Redis cache key eviction policy"
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
}

variable "aof_backup_configuration" {
  type = object({
    storage_connection_string_0 = string
    storage_connection_string_1 = string
  })
  description = "AOF Backup Configuration"
}

# variable "shard_count" {
#   type = number
#   description = "The number of shards in the redis cache"
# }