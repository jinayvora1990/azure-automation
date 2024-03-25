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
