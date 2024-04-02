

resource "azurerm_network_security_group" "avd_nsg" {
  location            = var.location
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.base_rg.name
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


resource "azurerm_subnet_network_security_group_association" "nsg_avd_assoc" {
  subnet_id = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.avd_nsg.id
  depends_on = [
    azurerm_subnet.subnet
  ]
}