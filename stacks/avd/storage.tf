module "tf_state_storage_account" {
  source = "../../../modules/storage"

  resource_group       = var.rg_name
  storage_account_name = var.storage_account_name
  containers_list      = var.containers_list
  skuname = var.skuname

  depends_on = [module.resource_group]
}
