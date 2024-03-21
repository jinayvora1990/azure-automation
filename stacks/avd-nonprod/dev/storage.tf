module "tf_state_storage_account" {
  source = "../../../modules/storage"

  resource_group       = azurerm_resource_group.rg.name
  storage_account_name = "adcb-storage-account-123"
  containers_list = [
    { name = "azstore", access_type = "private" }
  ]
}