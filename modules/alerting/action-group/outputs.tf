output "id" {
  value = values(azurerm_monitor_action_group.action_group)[*].id
}

output "name" {
  value = values(azurerm_monitor_action_group.action_group)[*].name
}
