output "dns_zone_name" {
  value = azurerm_private_dns_zone.pvt_dns.name
}

output "dns_zone_id" {
  value = azurerm_private_dns_zone.pvt_dns.id
}