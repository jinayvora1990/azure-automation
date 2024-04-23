output "name" {
  description = "The name of the function app"
  value       = azurerm_linux_function_app.function-app.name
}

output "id" {
  description = "The id of the function app"
  value       = azurerm_linux_function_app.function-app.id
}

output "hostname" {
  description = "The default hostname of the function app"
  value       = azurerm_linux_function_app.function-app.default_hostname
}

output "backend_storage_account_name" {
  description = "The name of the backend storage account used for the function app"
  value       = module.storage_account.storage_account_name
}