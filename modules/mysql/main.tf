resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  name                = "mysql-${var.application_name}-${local.environment}-${local.region_shortcode}-1"
  resource_group_name = var.resource_group_name
  location            = local.location
  version             = var.mysql_version
  delegated_subnet_id = data.azurerm_subnet.mysql_subnet.id
  create_mode         = var.create_mode
  sku_name            = var.sku_name

  administrator_login          = local.administrator_login
  administrator_password       = local.administrator_password
  zone                         = var.availability_zone
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled


  dynamic "maintenance_window" {
    for_each = local.maintenance_window_enabled ? { maintenance_window = var.maintenance_window } : {}
    content {
      day_of_week  = maintenance_window.value["day_of_week"]
      start_hour   = maintenance_window.value["start_hour"]
      start_minute = maintenance_window.value["start_minute"]
    }
  }

  dynamic "high_availability" {
    for_each = var.high_availability_enabled ? toset([var.standby_availability_zone]) : toset([])

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = high_availability.value
    }
  }

  dynamic "storage" {
    for_each = var.mysql_storage != null ? { mysql_storage = var.mysql_storage } : {}

    content {
      auto_grow_enabled  = mysql_storage.auto_grow_enabled
      io_scaling_enabled = mysql_storage.io_scaling_enabled
      iops               = mysql_storage.iops
      size_gb            = mysql_storage.size_gb
    }
  }

  tags = var.tags
}

resource "azurerm_mysql_flexible_server_configuration" "mysql_configuration" {
  for_each = var.server_configuration

  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.name
  name                = each.key
  value               = each.value.config_value

  depends_on = [
    azurerm_mysql_flexible_server.mysql_flexible_server
  ]
}

resource "azurerm_private_endpoint" "pep" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = format("pep-mysql-%s-%s-%s", var.application_name, local.environment, local.region_shortcode)
  location            = local.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.privatelink_subnet[0].id

  private_service_connection {
    name                           = format("%s%s", azurerm_mysql_flexible_server.mysql_flexible_server.name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql_flexible_server.id
    subresource_names              = ["mysqlServer"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}


resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-flexi-mysql-${local.environment}"
  target_resource_id             = azurerm_mysql_flexible_server.mysql_flexible_server.id
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