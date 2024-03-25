resource "azurerm_redis_cache" "rediscache" {
  name                 = "example-cache"
  location             = var.resource_location
  resource_group_name  = var.resource_group_name
  sku_name             = var.cache_tier.sku_name
  family               = var.cache_tier.family
  capacity             = var.cache_tier.capacity
  enable_non_ssl_port  = false
  minimum_tls_version  = var.min_tls_version
  replicas_per_primary = var.replicas
  # shard_count = var.shard_count


  redis_configuration {
    maxmemory_policy = var.max_memory_policy

    rdb_backup_enabled            = var.rdb_backup_enabled
    rdb_backup_frequency          = var.rdb_backup_configuration.backup_frequency
    rdb_backup_max_snapshot_count = var.rdb_backup_configuration.max_snapshot_count
    rdb_storage_connection_string = var.rdb_backup_configuration.storage_connection_string

    aof_backup_enabled              = var.aof_backup_enabled
    aof_storage_connection_string_0 = var.aof_backup_configuration.storage_connection_string_0
    aof_storage_connection_string_1 = var.aof_backup_configuration.storage_connection_string_1
  }
}