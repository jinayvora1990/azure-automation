#resource "azurerm_subnet" "avd_subnet" {
#  provider                     = azurerm.avd
#  count                        = length(var.subnets)
#  name                         = var.subnets[count.index].name
#  resource_group_name          = var.resource_group_name
#  virtual_network_name         = var.virtual_network_name
#  address_prefixes             = var.subnets[count.index].address_prefixes
#  private_endpoint_network_policy = var.subnets[count.index].private_endpoint_network_policy
#  depends_on                   = [azurerm_network_security_group.avd_nsg] + var.subnets[count.index].depends_on
#}
#

resource "azurerm_subnet" "avd_subnet" {
  provider                     = azurerm.avd
  for_each                     = { for idx, subnet in var.subnets : idx => subnet }
  name                         = each.value.name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  address_prefixes             = each.value.address_prefixes
  private_endpoint_network_policy = each.value.private_endpoint_network_policy
  depends_on                   = [azurerm_network_security_group.avd_nsg] + each.value.depends_on
}



