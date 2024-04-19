output "name" {
  description = "The name of the linux web app"
  value       = azurerm_linux_web_app.linux-web-app.name
}

output "id" {
  description = "The id of the linux web app"
  value       = azurerm_linux_web_app.linux-web-app.id
}

output "hostname" {
  description = "The default hostname of the linux web app"
  value       = azurerm_linux_web_app.linux-web-app.default_hostname
}

output "kind" {
  description = "The kind of the linux web app"
  value       = azurerm_linux_web_app.linux-web-app.kind
}