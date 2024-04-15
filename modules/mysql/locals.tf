data "azurerm_subscription" "primary" {}
data "azuread_client_config" "current" {}

locals {
  subscription_id            = data.azurerm_subscription.primary.id
  location                   = lower(var.location)
  region_shortcode           = (local.location == "uaenorth" ? "uan" : "unknown")
  environment                = lower(var.environment)
  mysql_resource_group_name  = var.resource_group
  maintenance_window_enabled = var.maintenance_window != null

  administrator_login    = data.azurerm_key_vault_secret.mysql_admin_username.value
  administrator_password = data.azurerm_key_vault_secret.mysql_admin_password.value

  common_tags = { module = "mysql-flexi-server" }
}