output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_private_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
}

output "aks_public_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.fqdn
}

output "aks_portal_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.portal_fqdn
}

output "aks_client_certificate" {
  value     = element(var.azure_active_directory_managed && var.enable_local_account ? azurerm_kubernetes_cluster.aks_cluster.kube_admin_config : azurerm_kubernetes_cluster.aks_cluster.kube_config, 0).client_certificate
  sensitive = true
}

output "aks_client_key" {
  value     = element(var.azure_active_directory_managed && var.enable_local_account ? azurerm_kubernetes_cluster.aks_cluster.kube_admin_config : azurerm_kubernetes_cluster.aks_cluster.kube_config, 0).client_key
  sensitive = true
}

output "aks_cluster_ca_certificate" {
  value     = element(var.azure_active_directory_managed && var.enable_local_account ? azurerm_kubernetes_cluster.aks_cluster.kube_admin_config : azurerm_kubernetes_cluster.aks_cluster.kube_config, 0).cluster_ca_certificate
  sensitive = true
}

output "aks_oms_agent_identity_object_id" {
  value = local.oms_agent_enabled ? try(azurerm_kubernetes_cluster.aks_cluster.oms_agent[0].oms_agent_identity[0].object_id) : null
}

output "aks_user_assigned_identity_id" {
  value = try(azurerm_user_assigned_identity.aks.id)
}

output "aks_network_plugin" {
  value = var.aks_network_plugin
}

output "aks_node_resource_group" {
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

output "aks_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}