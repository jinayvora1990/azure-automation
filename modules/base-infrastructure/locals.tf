data "azurerm_subscription" "primary" {}
data "azuread_client_config" "current" {}

locals {
  subscription_id  = data.azurerm_subscription.primary.id
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  environment      = lower(var.environment)

  if_ddos_enabled = var.create_ddos_plan ? [{}] : []
}