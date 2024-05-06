output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the Virtual Network"
}

output "subnet_names" {
  value = values(azurerm_subnet.snet)[*].name
}