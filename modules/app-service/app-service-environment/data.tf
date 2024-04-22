data "azurerm_subnet" "ase_subnet" {
  name                 = var.ase_subnet.name
  virtual_network_name = var.ase_subnet.vnet_name
  resource_group_name  = var.ase_subnet.resource_group
}