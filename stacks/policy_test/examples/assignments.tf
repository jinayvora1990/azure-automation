module "policy_assignment" {
  for_each = var.policy_details
  source   = "../../../modules/policy/modules/def_assignment"

  assignment_scope      = data.azurerm_subscription.current.id
  definition            = module.policy_definition[each.key].definition
  assignment_parameters = each.value.assignment_parameters
  assignment_effect     = each.value.assignment_effect
}