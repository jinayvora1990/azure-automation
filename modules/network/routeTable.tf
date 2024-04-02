resource "azurerm_route_table" "udr" {
  name                          = "route-snet-avd-prod-uaenorth-001"
  location                      = "uaenorth"
  resource_group_name           = "rg-vnet-avd-prod-uaenorth-01"
  disable_bgp_route_propagation = true

  route {
    name                   = "udr-to-fw"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "xxx.xxx1.4"
  }
}

resource "azurerm_subnet_route_table_association" "udr_avd_asso" {
  #provider       = azurerm.avd
  #subnet_id      = azurerm_subnet.avd_subnet.id
  subnet_id = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.udr.id
}

