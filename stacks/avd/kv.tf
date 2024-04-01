module "azure_key_vault" {
  source = "../../modules/key-vault"

  count = var.kv_name != null ? 1 : 0

  name                      = var.kv_name
  resource_group_name       = var.rg_name[0]
  enable_rbac_authorization = true

  depends_on = [module.resource_group]
}