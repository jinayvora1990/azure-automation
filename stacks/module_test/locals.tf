locals {
  #  tenant_id        = data.azurerm_subscription.primary.tenant_id
  #   location         = lower(var.location)
  #region_shortcode = (var.location == "uaenorth" ? "uan" : "unknown")
  environment = lower(var.environment)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}
