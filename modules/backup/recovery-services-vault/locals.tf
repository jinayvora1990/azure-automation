locals {
  common_tags = { module = "recovery-services-vault" }
  rg          = var.resource_group_name
  location    = lower(var.resource_location)
  location_shortcode_map = {
    "uaenorth"   = "uan"
    "uaecentral" = "uac"
  }
  location_shortcode  = lookup(local.location_shortcode_map, var.resource_location, substr(local.location, 0, 4))
  key_rotation_policy = var.encryption_config.encryption_key.rotation_policy
}