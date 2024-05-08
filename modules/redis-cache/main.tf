locals {
  common_tags = { module = "redis-cache" }
  rg          = var.resource_group_name
  location    = var.resource_location
  sku         = var.cache_tier.sku_name
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  environment = lower(var.environment)
}

module "res-id" {
  source = "../utility/random-identifier"
}

resource "azurerm_redis_cache" "rediscache" {
  name                          = format("redis-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
  location                      = local.location
  resource_group_name           = local.rg
  sku_name                      = var.cache_tier.sku_name
  family                        = var.cache_tier.family
  capacity                      = var.cache_tier.capacity
  enable_non_ssl_port           = false
  minimum_tls_version           = var.min_tls_version
  replicas_per_primary          = local.sku == "Premium" ? var.replicas : null
  shard_count                   = local.sku == "Premium" ? var.shard_count : null
  subnet_id                     = local.sku == "Premium" ? data.azurerm_subnet.redis_subnet[0].id : null
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
    rdb_backup_enabled            = local.sku == "Premium" ? var.rdb_backup_enabled : false
    rdb_backup_frequency          = local.sku == "Premium" && var.rdb_backup_enabled ? var.rdb_backup_configuration.backup_frequency : null
    rdb_backup_max_snapshot_count = local.sku == "Premium" && var.rdb_backup_enabled ? var.rdb_backup_configuration.max_snapshot_count : null
    rdb_storage_connection_string = local.sku == "Premium" && var.rdb_backup_enabled ? data.azurerm_storage_account.rdb_sa[0].primary_blob_connection_string : null

    #aof backup configuration
    aof_backup_enabled              = local.sku == "Premium" ? var.aof_backup_enabled : false
    aof_storage_connection_string_0 = local.sku == "Premium" && var.aof_backup_enabled ? data.azurerm_storage_account.aof_sa[0].primary_blob_connection_string : null
    aof_storage_connection_string_1 = local.sku == "Premium" && var.aof_backup_enabled ? data.azurerm_storage_account.aof_sa[0].secondary_blob_connection_string : null
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "redis-cache" })

  lifecycle {
    # A bug in the Redis API where the original storage connection string isn't being returned
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }
}

resource "azurerm_private_endpoint" "pep" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = format("redis-pep-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
  location            = local.location
  resource_group_name = local.rg
  subnet_id           = data.azurerm_subnet.privatelink_subnet[0].id

  private_service_connection {
    name                           = format("redis-pl-%s-%s-%s-%s", var.application_name, var.environment, lookup(local.location_short, var.resource_location, substr(var.resource_location, 0, 4)), module.res-id.result)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_cache.rediscache.id
    subresource_names              = ["redisCache"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}

resource "azurerm_private_dns_a_record" "dns_record" {
  count               = length(azurerm_private_endpoint.pep) > 0 && var.private_dns_zone_name != null ? 1 : 0
  name                = "redis"
  records             = [azurerm_private_endpoint.pep[0].private_service_connection[0].private_ip_address]
  resource_group_name = local.rg
  ttl                 = 300
  zone_name           = var.private_dns_zone_name
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-redis-cache-${local.environment}"
  target_resource_id             = azurerm_redis_cache.rediscache.id
  eventhub_authorization_rule_id = each.value.event_hub_authorization_rule_resource_id
  eventhub_name                  = each.value.event_hub_name
  log_analytics_destination_type = each.value.log_analytics_destination_type
  log_analytics_workspace_id     = each.value.workspace_resource_id
  partner_solution_id            = each.value.marketplace_partner_resource_id
  storage_account_id             = each.value.storage_account_resource_id

  dynamic "enabled_log" {
    for_each = each.value.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_log" {
    for_each = each.value.log_groups
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.metric_categories
    content {
      category = metric.value
    }
  }
}