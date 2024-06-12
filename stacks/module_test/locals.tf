locals {
  #  tenant_id        = data.azurerm_subscription.primary.tenant_id
  #   location         = lower(var.location)
  #region_shortcode = (var.location == "uaenorth" ? "uan" : "unknown")
  environment = lower(var.environment)
  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}
