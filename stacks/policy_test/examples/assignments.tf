##################
# General
##################
module "org_mg_whitelist_regions" {
  source           = "../../../modules/policyNew/modules/def_assignment"
  definition       = module.whitelist_regions.definition
  assignment_scope = data.azurerm_resource_group.scope.id
  #assignment_effect = "Deny"
}

module "org_rg_allowedsku" {
  source           = "../../../modules/policyNew/modules/def_assignment"
  definition       = module.storageAccountSKU.definition
  assignment_scope = data.azurerm_resource_group.scope.id
  #assignment_effect = "Deny"
}


#  assignment_parameters = {
#    listOfRegionsAllowed = ["uaenorth"] # Global is used in services such as Azure DNS
#  }
#
#  assignment_metadata = {
#    version  = "1.0.0"
#    category = "Batch"
#    cloud_envs = [
#      "AzureCloud",
#      "AzureChinaCloud",
#      "AzureUSGovernment"
#    ]
#  }

# optional resource selectors (preview)
#  resource_selectors = [
#    {
#      name = "SDPRegions"
#      selectors = {
#        kind = "resourceLocation"
#        in   = ["uk", "uksouth", "ukwest"]
#      }
#    }
#  ]


