# module "registry" {
#   source = "../../modules/container-registry"
#   application_name = var.application_name
#   environment = local.environment
#   resource_group_name = module.resource_group.rg_name
#   kv_name = module.azure_key_vault.name
#   azurerm_key_vault_key = "encryptionKey"
#   sku = "Premium"
#   images_retention_enabled = true
#   images_retention_days = 30
#   user_assigned_identity_name = "identity"
#   encryption_enabled = true
#   azure_services_bypass_allowed = true
# }