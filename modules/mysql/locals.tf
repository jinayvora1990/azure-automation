locals {
  location = lower(var.location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.location, substr(var.location, 0, 4))
  environment        = lower(var.environment)

  maintenance_window_enabled = var.maintenance_window != null
  administrator_login        = data.azurerm_key_vault_secret.mysql_admin_username.value
  administrator_password     = data.azurerm_key_vault_secret.mysql_admin_password.value

  common_tags = { module = "mysql-flexi-server" }
}