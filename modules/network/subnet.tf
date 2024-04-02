#resource "azurerm_subnet" "subnet" {
#  for_each                     = { for idx, subnet in var.subnets : idx => subnet }
#  name                         = each.value.name
#  resource_group_name          = azurerm_resource_group.base_rg.name
#  virtual_network_name         = azurerm_virtual_network.vnet.name
#  address_prefixes             = each.value.address_prefixes
#  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
#  #depends_on                   = [azurerm_network_security_group.avd_nsg]
#}



variable "private_endpoint_network_policies_enabled" {
  default = "true"
}
variable "subnet_name" {
}
variable "subnet_address_prefixes" {
  default = ""
}

resource "azurerm_subnet" "subnet" {
  name                         = var.subnet_name
  resource_group_name          = azurerm_resource_group.base_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  address_prefixes             = var.subnet_address_prefixes
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled
  #depends_on                   = [azurerm_network_security_group.avd_nsg]
}