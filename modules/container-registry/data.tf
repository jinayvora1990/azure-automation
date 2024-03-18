#data "azurerm_key_vault" "encryption" {
#  name                = var.key_vault_name
#  resource_group_name = var.resource_group_name
#}
#
#data "azurerm_key_vault_key" "example" {
#  name         = "super-secret"
#  key_vault_id = data.azurerm_key_vault.encryption.id
#}