resource "azurerm_virtual_network" "avd" {
  provider            = azurerm.avd
  name                = "vnet-avd-uaenorth-01"
  location            = azurerm_resource_group.avd.location
  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
  address_space       = ["xxx.xxx8.0/22"]
  dns_servers         = ["xxx.xxx6.4", "xxx.xxx6.5"]
}
