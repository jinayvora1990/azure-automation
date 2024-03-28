locals {
  common_tags = { module : "redis-cache" }
  rg          = var.resource_group_name
  location    = var.resource_location
}

resource "azurerm_redis_cache" "rediscache" {
  name                          = var.redis_cache_name
  location                      = local.location
  resource_group_name           = local.rg
  sku_name                      = var.cache_tier.sku_name
  family                        = var.cache_tier.family
  capacity                      = var.cache_tier.capacity
  enable_non_ssl_port           = false
  minimum_tls_version           = var.min_tls_version
  replicas_per_primary          = var.replicas
  shard_count                   = var.shard_count
  subnet_id                     = var.subnet_id
  public_network_access_enabled = false

  # Only available in preview
  # zones = var.zones

  dynamic "patch_schedule" {
    for_each = var.patch_schedules != null ? var.patch_schedules : []
    content {
      day_of_week    = patch_schedule.day_of_week
      start_hour_utc = patch_schedule.start_hour_utc
    }
  }

  redis_configuration {
    maxmemory_policy = var.cache_eviction_policy

    rdb_backup_enabled            = var.rdb_backup_enabled
    rdb_backup_frequency          = var.rdb_backup_configuration.backup_frequency
    rdb_backup_max_snapshot_count = var.rdb_backup_configuration.max_snapshot_count
    rdb_storage_connection_string = var.rdb_backup_configuration.storage_connection_string

    aof_backup_enabled              = var.aof_backup_enabled
    aof_storage_connection_string_0 = var.aof_backup_configuration.storage_connection_string_0
    aof_storage_connection_string_1 = var.aof_backup_configuration.storage_connection_string_1
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" : "redis-cache" })
}

resource "azurerm_private_endpoint" "pep" {
  name                = format("%s%s", var.redis_cache_name, "-private-endpoint")
  location            = local.location
  resource_group_name = local.rg
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = format("%s%s", var.redis_cache_name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_cache.rediscache.id
    subresource_names              = ["redisCache"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" : "private-endpoint", })
}

data "azurerm_private_endpoint_connection" "pep_connection" {
  name                = azurerm_private_endpoint.pep.name
  resource_group_name = local.rg
  depends_on          = [azurerm_redis_cache.rediscache]
}

