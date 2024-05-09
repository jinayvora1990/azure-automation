##################
# General
##################
module "org_mg_whitelist_regions" {
  source            = "../../../modules/policy/modules/def_assignment"
  definition        = module.whitelist_regions.definition
  assignment_scope  = data.azurerm_resource_group.scope.id
  assignment_effect = "Deny"
}

module "org_rg_allowedsku" {
  source           = "../../../modules/policy/modules/def_assignment"
  definition       = module.storageAccountSKU.definition
  assignment_scope = data.azurerm_resource_group.scope.id
  #assignment_effect = "Deny"
}

