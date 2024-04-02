resource "azurerm_route_table" "udr" {
  for_each                      = var.subnets
  name                          = lower("rt_${each.key}")
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true

  # Add tags

  # Need to fix Route Table
  dynamic "route" {
    for_each = var.subnets
    content {
      name                   = "udr-to-fw"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "xxx.xxx1.4"
    }
  }
}

resource "azurerm_subnet_route_table_association" "rt-assoc" {
  for_each       = var.subnets
  subnet_id      = azurerm_subnet.snet[each.key].id
  route_table_id = azurerm_route_table.udr[each.key].id
}