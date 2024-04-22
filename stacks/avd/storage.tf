module "azure_storage_account" {
  source = "../../modules/storage"

  for_each = { for sa in var.storage_accounts : sa.name => sa }

  resource_group       = each.value.resource_group
  storage_account_name = each.value.name
  containers_list      = toset(each.value.containers)
  skuname              = each.value.skuname

  depends_on = [module.resource_group]
  application_name = "cibg"
  privatelink_subnet = {
    name = "default"
    vnet_name = "aks-vnet-test"
    resource_group = "aks-test-rg"
  }
}
