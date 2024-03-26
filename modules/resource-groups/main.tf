resource "azurerm_resource_group" "rg" {
  for_each = toset(var.rg_name)

  name     = each.value
  location = var.location
  tags     = var.tags
}
