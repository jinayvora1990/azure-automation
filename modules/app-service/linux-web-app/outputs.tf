# output "hostname" {
#   description = "Hostname of the redis-cache"
#   value       = azurerm_redis_cache.rediscache.hostname
# }
#
# output "ssl_port" {
#   description = "ssl port of the redis cache"
#   value       = azurerm_redis_cache.rediscache.ssl_port
# }
#
# output "primary_access_key" {
#   description = "The primary access key for the redis cache"
#   value       = azurerm_redis_cache.rediscache.primary_access_key
#   sensitive   = true
# }
#
# output "secondary_access_key" {
#   description = "The secondary access key for the redis cache"
#   value       = azurerm_redis_cache.rediscache.secondary_access_key
#   sensitive   = true
# }
#
# output "primary_connection_string" {
#   description = "The primary connection string for the redis cache"
#   value       = azurerm_redis_cache.rediscache.primary_connection_string
# }
#
# output "secondary_connection_string" {
#   description = "The secondary connection string for the redis cache"
#   value       = azurerm_redis_cache.rediscache.secondary_connection_string
# }
#
# output "redis_cache_private_endpoint" {
#   description = "id of the Redis Cache Private Endpoint"
#   value       = azurerm_private_endpoint.pep.id
# }
#
# output "redis_cache_private_endpoint_ip" {
#   description = "Redis Cache server private endpoint IPv4 Addresses"
#   value       = element(concat(data.azurerm_private_endpoint_connection.pep_connection.private_service_connection.0.private_ip_address, [""]), 0)
# }