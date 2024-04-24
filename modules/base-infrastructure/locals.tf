locals {
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  environment      = lower(var.environment)

  if_ddos_enabled = var.create_ddos_plan ? [{}] : []
}