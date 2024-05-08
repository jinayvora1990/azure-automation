locals {
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  environment      = lower(var.environment)

  maintenance_window_enabled = var.maintenance_window != null
  administrator_login        = data.azurerm_key_vault_secret.mysql_admin_username.value
  administrator_password     = data.azurerm_key_vault_secret.mysql_admin_password.value

  common_tags = { module = "mysql-flexi-server" }
}