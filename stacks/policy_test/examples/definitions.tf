module "whitelist_regions" {
  source          = "../../../modules/policy/modules/definition"
  policy_name     = "whitelist_regions"
  display_name    = "Whitelist Azure Regions"
  policy_category = "General"
  #  management_group_id = data.azurerm_resource_group.scope.id
}

module "storageAccountSKU" {
  source          = "../../../modules/policy/modules/definition"
  policy_name     = "allowedsku"
  display_name    = "Allowed Storage Account SKU"
  policy_category = "storage"
}