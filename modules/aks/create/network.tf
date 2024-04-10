# resource "azurerm_role_assignment" "learned_routes_network_contributor_role" {
#   scope                = "/subscriptions/${local.subscription_id}/resourceGroups/${local.networking_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.networking_learnedroutes_vnet_name}"
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_user_assigned_identity.aks.principal_id

#   depends_on = [azurerm_subnet.aks_subnet, azurerm_user_assigned_identity.aks]
# }