module "res-id" {
  source = "../utility/random-identifier"
}

resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                = "psql-${var.application_name}-${local.environment}-${local.location_shortcode}-${module.res-id.result}"
  resource_group_name = var.resource_group_name
  location            = local.location
  version             = var.sql_version
  delegated_subnet_id = data.azurerm_subnet.psql_subnet.id
  create_mode         = var.create_mode
  private_dns_zone_id = var.private_dns_zone_id

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

  dynamic "identity" {
    for_each = var.identities
    content {
      identity_ids = identity
      type         = "UserAssigned"
    }
  }

  storage_mb   = var.storage_in_mb
  storage_tier = var.storage_tier
  sku_name     = var.sku_name

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_configuration" "postgres_configuration" {
  for_each = var.server_configuration

  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  name      = each.key
  value     = each.value.config_value

  depends_on = [
    azurerm_postgresql_flexible_server.postgresql_flexible_server
  ]
}

resource "azurerm_postgresql_flexible_server_configuration" "postgres_pgbouncer_configuration" {
  for_each = var.additional_pgbouncer_settings

  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  name      = each.key
  value     = each.value.config_value

  depends_on = [
    azurerm_postgresql_flexible_server_configuration.postgres_configuration
  ]
}

# resource "azurerm_private_dns_a_record" "dns_record" {
#   count               = length(azurerm_private_endpoint.pep) > 0 && var.private_dns_zone_name != null ? 1 : 0
#   name                = "postgres"
#   records             = [azurerm_private_endpoint.pep[0].private_service_connection[0].private_ip_address]
#   resource_group_name = var.resource_group_name
#   ttl                 = 300
#   zone_name           = var.private_dns_zone_name
# }

resource "azurerm_private_endpoint" "pep" {
  count               = var.privatelink_subnet != null ? 1 : 0
  name                = format("pep-psql-%s-%s-%s", var.application_name, local.environment, local.location_shortcode)
  location            = local.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.privatelink_subnet[0].id

  private_service_connection {
    name                           = format("%s%s", azurerm_postgresql_flexible_server.postgresql_flexible_server.name, "-privatelink")
    is_manual_connection           = false
    private_connection_resource_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
    subresource_names              = ["postgresqlServer"]
  }

  tags = merge(var.tags, local.common_tags, { "resource_type" = "private-endpoint" })
}


resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-flexi-postgres-${local.environment}"
  target_resource_id             = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
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