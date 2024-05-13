module "policy_definition" {
  for_each    = var.policy_details
  source      = "../../../modules/policy/modules/definition"
  policy_name = each.key
}