resource "azurerm_virtual_network_peering" "peer-avd-to-Hub" {

  count = var.hub_vnet_id != null ? 1 : 0

  name                         = "peer-vnet-${var.app_name}-${local.environment}-${local.region_shortcode}-1-to-Hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = "vnet-${var.app_name}-${local.environment}-${local.region_shortcode}-1"
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = true
}