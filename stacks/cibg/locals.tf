locals {
  environment      = var.environment
  application_name = var.application_name
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")

  tags = {
    project = "adcb"
    owners  = "jinay"
  }
}