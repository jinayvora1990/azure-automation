module "key_vault" {
  source = "../../modules/key-vault"

  name                     = "container-registry-kv"
  resource_group_name      = module.container_registry.resource_group_name
  purge_protection_enabled = true
  enable_rbac_authorization = true
}