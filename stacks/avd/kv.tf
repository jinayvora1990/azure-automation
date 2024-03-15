module "key_vault" {
  source = "../../modules/key-vault"

  name                      = "container-registry-kvs"
  resource_group_name       = azurerm_resource_group.rg.name
  purge_protection_enabled  = true
  enable_rbac_authorization = true
}