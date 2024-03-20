resource "azurerm_network_security_group" "avd_nsg" {
  provider            = azurerm.avd
  location            = var.location
  name                = "nsg-snet-avd-prod-uaenorth-001"
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefixes    = security_rule.value.source_address_prefixes
      destination_address_prefix = security_rule.value.destination_address_prefixes
      description                = security_rule.value.description
    }
  }
}


resource "azurerm_network_security_group" "avd_pe_nsg" {
  provider            = azurerm.avd
  location            = "uaenorth"
  name                = "nsg-snet-pe-prod-uaenorth-001"
  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
}


resource "azurerm_subnet_network_security_group_association" "nsg_avd_assoc" {
  provider                  = azurerm.avd
  subnet_id                 = azurerm_subnet.avd_subnet.id
  network_security_group_id = azurerm_network_security_group.avd_nsg.id
  depends_on = [
    azurerm_subnet.avd_subnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_w365_assoc" {
  provider                  = azurerm.avd
  subnet_id                 = azurerm_subnet.w365_subnet.id
  network_security_group_id = azurerm_network_security_group.avd_nsg.id
  depends_on = [
    azurerm_subnet.avd_subnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_pe_assoc" {
  provider                  = azurerm.avd
  subnet_id                 = azurerm_subnet.private_endpoint_subnet.id
  network_security_group_id = azurerm_network_security_group.avd_pe_nsg.id
}