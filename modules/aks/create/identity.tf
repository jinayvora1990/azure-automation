resource "azurerm_user_assigned_identity" "aks" {
  name                = local.aks_user_assigned_identity_name
  location            = local.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  lifecycle {
    ignore_changes = [tags["creator"], tags["created_on"]]
  }
}

resource "azurerm_user_assigned_identity" "kubelet" {
  count = var.enable_kubelet_identity ? 1 : 0

  name                = local.aks_kubelet_identity_name
  location            = local.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  lifecycle {
    ignore_changes = [tags["creator"], tags["created_on"]]
  }
}

resource "azurerm_role_assignment" "kubelet_identity_role_assignment_managed_identity" {
  count = var.enable_kubelet_identity ? 1 : 0

  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  scope                = azurerm_user_assigned_identity.kubelet[0].id
  role_definition_name = "Managed Identity Operator"
}