module "container_registry" {
  source = "../../modules/container-registry"

  registry_name               = "adcbcontregistryadagasg"
  registry_sku                = "Premium"
  resource_group_name         = azurerm_resource_group.rg.name
  user_assigned_identity_name = "registry-uai"
  key_vault_name              = module.key_vault.key_vault_name

  depends_on = [ module.key_vault ]
}