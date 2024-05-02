data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet.name
  virtual_network_name = var.aks_subnet.vnet_name
  resource_group_name  = var.aks_subnet.resource_group
}

data "azurerm_container_registry" "acr" {
  for_each = toset(var.acr_names)

  name                = each.value
  resource_group_name = var.resource_group_name
}