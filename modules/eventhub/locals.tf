locals {
  common_tags = { module = "event-hub" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_short = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  capture_config_list = [for eventhub in var.eventhub_config : eventhub.capture_config if eventhub.enable_capture]
}