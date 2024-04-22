resource "azurerm_private_dns_zone" "private_dns_zone" {
  count = local.private_dns_zone_count

  name                = "privatelink.${local.location}.azmk8s.io"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [tags["creator"], tags["created_on"]]
  }
}

resource "azurerm_role_assignment" "private_dns_zone_contributor" {
  count = local.private_dns_zone_count

  scope                = azurerm_private_dns_zone.private_dns_zone[0].id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_role_assignment" "custom_private_dns_zone_contributor" {
  count = local.custom_private_dns_zone_role_assignment_count

  scope                = var.aks_private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}