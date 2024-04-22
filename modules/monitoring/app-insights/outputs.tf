output "id" {
  description = "Id of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_insights.id, null)
}

output "name" {
  description = "Name of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_insights.name, null)
}

output "app_id" {
  description = "App id of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_insights.app_id, null)
}

output "instrumentation_key" {
  description = "Instrumentation key of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_insights.instrumentation_key, null)
  sensitive   = true
}

output "application_type" {
  description = "Application Type of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_insights.application_type, null)
}

output "connection_string" {
  description = "The Connection String for this Application Insights component"
  value       = try(azurerm_application_insights.app_insights.connection_string, null)
}