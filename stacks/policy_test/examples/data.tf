#data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "current" {
  name = "aks-test-rg"
}