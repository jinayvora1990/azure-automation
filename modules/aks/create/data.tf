data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet.name
  virtual_network_name = var.aks_subnet.vnet_name
  resource_group_name  = var.aks_subnet.resource_group
}

data "azurerm_container_registry" "acr" {
  for_each            = { for acr in var.acr : acr.name => acr }
  name                = each.value.name
  resource_group_name = each.value.resource_group
}