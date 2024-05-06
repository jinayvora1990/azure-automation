data "azurerm_subscription" "primary" {}

locals {
  tenant_id        = data.azurerm_subscription.primary.tenant_id
  location         = lower(var.location)
  region_shortcode = (local.location == "uaenorth" ? "uan" : "unknown")
  environment      = lower(var.environment)

  private_dns_zone_enabled                      = var.enable_private_cluster && var.create_private_dns_zone
  private_dns_zone_count                        = local.private_dns_zone_enabled ? 1 : 0
  custom_private_dns_zone_role_assignment_count = var.enable_private_cluster && var.aks_private_dns_zone_role_assignment ? 1 : 0
  aks_private_dns_zone_id                       = var.aks_private_dns_zone_id != null ? var.aks_private_dns_zone_id : (local.private_dns_zone_enabled ? azurerm_private_dns_zone.private_dns_zone[0].id : "System")
  oms_agent_enabled                             = (var.oms_agent_log_analytics_workspace_id == "" ? false : true)
  oms_agent_block_enabled                       = (local.oms_agent_enabled ? [{}] : [])
  aks_user_assigned_identity_name               = "aks-${var.application_name}-${local.environment}-${local.region_shortcode}-${var.aks_name_suffix}"
  aks_kubelet_identity_name                     = "aks-${var.application_name}-${local.environment}-${local.region_shortcode}-${var.aks_name_suffix}-kubelet"
}