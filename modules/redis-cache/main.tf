locals {
  common_tags  = { module = "redis-cache" }
  rg           = var.resource_group_name
  location     = var.resource_location
  subnet_id    = data.azurerm_subnet.subnet.id
  subscription = var.cache_tier.sku_name
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
  replicas_per_primary          = local.subscription == "Premium" ? var.replicas : null
  shard_count                   = local.subscription == "Premium" ? var.shard_count : null
  subnet_id                     = local.subscription == "Premium" ? local.subnet_id : null
  public_network_access_enabled = false

  # Only available in preview
  # zones = var.zones

  dynamic "patch_schedule" {
    for_each = var.patch_schedules != null ? var.patch_schedules : []
    content {
      day_of_week    = patch_schedule.value["day_of_week"]
      start_hour_utc = patch_schedule.value["start_hour_utc"]
    }
  }

  redis_configuration {
    maxmemory_policy = var.cache_eviction_policy

    #rdb backup configuration
    rdb_backup_enabled            = local.subscription == "Premium" ? var.rdb_backup_enabled : false
    rdb_backup_frequency          = local.subscription == "Premium" ? var.rdb_backup_configuration.backup_frequency : null
    rdb_backup_max_snapshot_count = local.subscription == "Premium" ? var.rdb_backup_configuration.max_snapshot_count : null
    rdb_storage_connection_string = local.subscription == "Premium" ? data.azurerm_storage_account.rdb_sa.0.primary_blob_connection_string : null

    #aof backup configuration
    aof_backup_enabled              = local.subscription == "Premium" ? var.aof_backup_enabled : false
    aof_storage_connection_string_0 = local.subscription == "Premium" ? data.azurerm_storage_account.aof_sa.primary_blob_connection_string : null
    aof_storage_connection_string_1 = local.subscription == "Premium" ? data.azurerm_storage_account.aof_sa.secondary_blob_connection_string : null
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "redis-cache" })

  lifecycle {
    # A bug in the Redis API where the original storage connection string isn't being returned
    ignore_changes = [redis_configuration.0.rdb_storage_connection_string]
  }
}

resource "azurerm_private_endpoint" "pep" {
  name                = format("%s%s", var.redis_cache_name, "-private-endpoint")
  location            = local.location
  resource_group_name = local.rg
  subnet_id           = local.subnet_id

  private_service_connection {
    name                           = format("%s%s", var.redis_cache_name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_cache.rediscache.id
    subresource_names              = ["redisCache"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}

resource "azurerm_monitor_diagnostic_setting" "extaudit" {
  count                      = var.log_analytics.workspace_name != null ? 1 : 0
  name                       = format("%s%s", var.redis_cache_name, "-monitoring")
  target_resource_id         = azurerm_redis_cache.rediscache.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_ws.0.id
  #  storage_account_id         = var.enable_data_persistence ? azurerm_storage_account.storeacc.0.id : null

  metric {
    category = "AllMetrics"
  }

  lifecycle {
    ignore_changes = [metric]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "log-analytics-monitoring" })
}