output "workspace_name" {
  description = "The name of this Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.name
}

output "workspace_id" {
  description = "The ID of this Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "workspace_customer_id" {
  description = "The workspace (customer) ID of this Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.workspace_id
}

output "primary_shared_key" {
  description = "The primary shared key of this Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
}

output "secondary_shared_key" {
  description = "The secondary shared key of this Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.secondary_shared_key
}