resource "azurerm_resource_group" "rg" {
  name     = "sample-resources"
  location = "uaenorth"
  tags = {
    owners  = "jinay.vora@thoughtworks.com"
    project = "adcb"
  }
}