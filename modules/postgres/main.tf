resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                = "flexi-postgres-${var.environment}"
  resource_group_name = local.postgresql_resource_group_name
  location            = local.location
  version             = var.sql_version
  delegated_subnet_id = data.azurerm_subnet.subnet.id
  create_mode         = var.create_mode

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

  storage_mb = var.storage_in_mb
  sku_name   = var.sku_name

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