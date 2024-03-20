resource "azurerm_resource_group" "base_rg" {
  name     = "${var.app_name}-${var.env}-base-rg"
  location = var.location
}