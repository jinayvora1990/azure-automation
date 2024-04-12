resource "azurerm_log_analytics_workspace" "example" {
  name                = "aks-diagnostic-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

#resource "azurerm_monitor_diagnostic_setting" "example" {
#  name                       = "aks-diagnostic-settings"
#  target_resource_id         = azurerm_kubernetes_cluster.aks_cluster.id
#  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
#log_analytics_destination_type = "Dedicated"
#  enabled_log {
#    category = "kube-apiserver"
#  }
#
#  enabled_log {
#    category = "kube-audit"
#  }
#
#  enabled_log {
#    category = "kube-controller-manager"
#  }
#
#  enabled_log {
#    category = "kube-scheduler"
#  }
#
#}