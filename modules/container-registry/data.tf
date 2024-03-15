data "azurerm_key_vault" "encryption" {
  name                = "container-registry-kv"
  resource_group_name = "example-resources"
}

data "azurerm_key_vault_key" "example" {
  name         = "super-secret"
  key_vault_id = data.azurerm_key_vault.encryption.id

  # depends_on = [ azurerm_role_assignment.admin_access_role_assignment ]
}