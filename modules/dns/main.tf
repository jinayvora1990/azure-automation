resource "azurerm_private_dns_zone" "pvt_dns" {
  name                = var.dns_zone_name
  resource_group_name = local.rg
  tags                = merge(var.tags, local.common_tags, { "resource_type" = "private-dns-zone" })
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "${var.dns_zone_name}_dns_vnet_link"
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns.name
  resource_group_name   = local.rg
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  tags                  = merge(var.tags, local.common_tags, { "resource_type" = "private-dns-zone-vnet-link" })
}