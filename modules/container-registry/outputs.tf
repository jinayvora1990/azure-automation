output "acr_name" {
  description = "Azure Container Registry Name"
  value       = azurerm_container_registry.acr.name
}

output "acr_rg" {
  description = "Azure Container Registry Resource Group"
  value       = azurerm_container_registry.acr.resource_group_name
}