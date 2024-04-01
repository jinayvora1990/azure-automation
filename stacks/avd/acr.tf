module "azure_container_registry" {
  source = "../../modules/container-registry"

  count = var.acr_name != null ? 1 : 0

  registry_name               = var.acr_name
  resource_group_name         = var.rg_name[0]
  user_assigned_identity_name = "kv_acr_mi"
  registry_sku                = "Premium"
  kv_name                     = var.kv_name
  azurerm_key_vault_key       = "acr-encryption"

  depends_on = [module.azure_key_vault]
}