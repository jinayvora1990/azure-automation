resource "azurerm_virtual_network_peering" "peer-avd-to-Hub" {

  count = var.hub_vnet_id != null ? 1 : 0

  name                         = "peer-${local.vnet_name}-to-Hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = local.vnet_name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = true
}