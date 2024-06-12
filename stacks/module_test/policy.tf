module "policy_definition" {
  for_each    = var.provision_modules.policy ? var.policy_details : {}
  source      = "../../modules/policy/modules/definition"
  policy_name = each.key
}

module "policy_assignment" {
  for_each = var.provision_modules.policy ? var.policy_details : {}
  source   = "../../modules/policy/modules/def_assignment"

  assignment_scope      = module.resource_group[0].rg_id
  definition            = module.policy_definition[each.key].definition
  assignment_parameters = each.value.assignment_parameters
  assignment_effect     = each.value.assignment_effect
}