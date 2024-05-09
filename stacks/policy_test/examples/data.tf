#data "azurerm_client_config" "current" {}
#
#data "azurerm_subscription" "current" {}


data "azurerm_resource_group" "scope" {
  name = "aks-test-rg"
}
