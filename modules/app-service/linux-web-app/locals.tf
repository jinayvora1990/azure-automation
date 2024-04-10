locals {
  common_tags    = { module = "redis-cache" }
  rg             = var.resource_group_name
  location       = var.resource_location
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }

  #Variables Validation
  rules = var.ip_restriction.rules
}