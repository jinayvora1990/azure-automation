output "hostname" {
  description = "Hostname of the redis-cache"
  value       = azurerm_redis_cache.rediscache.hostname
}

output "ssl_port" {
  description = "ssl port of the redis cache"
  value       = azurerm_redis_cache.rediscache.ssl_port
}

output "primary_access_key" {
  description = "The primary access key for the redis cache"
  value       = azurerm_redis_cache.rediscache.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the redis cache"
  value       = azurerm_redis_cache.rediscache.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the redis cache"
  value       = azurerm_redis_cache.rediscache.primary_connection_string
}

output "secondary_connection_string" {
  description = "The secondary connection string for the redis cache"
  value       = azurerm_redis_cache.rediscache.secondary_connection_string
}

output "redis_cache_private_endpoint_ip" {
  description = "Redis Cache server private endpoint IPv4 Addresses"
  value       = concat(data.azurerm_private_endpoint_connection.pep_connection[0].private_service_connection[*].private_ip_address, [""])
}

output "pep_pvt_dns_fqdn" {
  description = "FQDN for the redis cache private endpoint in private dns zone"
  value       = var.privatelink_subnet != null && var.private_dns_zone_name != null ? "${azurerm_private_dns_a_record.dns_record[0].name}.${var.private_dns_zone_name}" : null
}