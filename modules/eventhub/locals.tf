locals {
  common_tags = { module = "event-hub" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode  = lookup(local.location_shortcode_map, var.resource_location, substr(local.location, 0, 4))
  capture_config_list = [for eventhub in var.eventhub_config : eventhub.capture_config if eventhub.enable_capture]
}