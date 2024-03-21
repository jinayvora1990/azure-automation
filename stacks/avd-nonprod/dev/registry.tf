module "container_registry" {
  source = "../../../modules/container-registry"

  registry_name               = "adcbcontregistryadagasg"
  registry_sku                = "Premium"
  resource_group_name         = azurerm_resource_group.rg.name
  user_assigned_identity_name = "registry-uai"
  azurerm_key_vault_key       = "super-secret"
  azurerm_key_vault           = module.key_vault.azurerm_key_vault
}