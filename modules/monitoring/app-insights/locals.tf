locals {
  common_tags = { module = "app-service" }
  rg          = var.resource_group_name
  location    = var.resource_location
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode = lookup(local.location_shortcode_map, var.resource_location, substr(var.resource_location, 0, 4))
}