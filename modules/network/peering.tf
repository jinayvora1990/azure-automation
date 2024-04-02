
#Create Peering to Hub

resource "azurerm_virtual_network_peering" "peer-avd-to-Hub" {
#  provider                     = azurerm.avd
  name                         = var.peering_to_hub_name
  resource_group_name          = azurerm_resource_group.base_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
 # "vnet-avd-uaenorth-01"
  remote_virtual_network_id    = "/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-hub-uaenorth-01/providers/Microsoft.Network/virtualNetworks/vnet-connectivity-hub-uaenorth-01"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = true
}