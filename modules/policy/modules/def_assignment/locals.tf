locals {
  # assignment_name at MG scope will be trimmed if exceeds 24 characters
  assignment_name_trim = local.assignment_scope.mg > 0 ? 24 : 64
  assignment_name      = try(lower(substr(coalesce(var.assignment_name, var.definition.name), 0, local.assignment_name_trim)), "")
  display_name         = try(coalesce(var.assignment_display_name, var.definition.display_name), "")
  description          = try(coalesce(var.assignment_description, var.definition.description), "")
  metadata             = jsonencode(try(coalesce(var.assignment_metadata, jsondecode(var.definition.metadata)), {}))

  # convert assignment parameters to the required assignment structure
  parameter_values = var.assignment_parameters != null ? {
    for key, value in var.assignment_parameters :
    key => merge({ value = value })
  } : null

  # merge effect with parameter_values if specified, will use definition defaults if omitted
  parameters = local.parameter_values != null ? var.assignment_effect != null ? jsonencode(merge(local.parameter_values, { effect = { value = var.assignment_effect } })) : jsonencode(local.parameter_values) : null

  # create the optional non-compliance message contents block if present
  non_compliance_message = contains(["All", "Indexed"], try(var.definition.mode, "")) ? { content = try(coalesce(var.non_compliance_message, local.description, local.display_name, "Flagged by Policy: ${local.assignment_name}", "")) } : {}

  # determine if a managed identity should be created with this assignment
  identity_type = length(try(coalescelist(var.role_definition_ids, lookup(jsondecode(var.definition.policy_rule).then.details, "roleDefinitionIds", [])), [])) > 0 ? var.identity_ids != null ? { type = "UserAssigned" } : { type = "SystemAssigned" } : {}

  # try to use policy definition roles if explicit roles are omitted
  role_definition_ids = var.skip_role_assignment == false && try(values(local.identity_type)[0], "") == "SystemAssigned" ? try(coalescelist(var.role_definition_ids, lookup(jsondecode(var.definition.policy_rule).then.details, "roleDefinitionIds", [])), []) : []

  # policy assignment scope will be used if omitted
  role_assignment_scope = try(coalesce(var.role_assignment_scope, var.assignment_scope), "")

  # if creating role assignments also create a remediation task for policies with DeployIfNotExists and Modify effects
  create_remediation = var.assignment_enforcement_mode == true && var.skip_remediation == false && length(local.identity_type) > 0 ? 1 : 0

  # assignment location is required when identity is specified
  assignment_location = length(local.identity_type) > 0 ? var.assignment_location : null

  # evaluate policy assignment scope from resource identifier
  assignment_scope = try({
    mg       = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) > 0 ? 1 : 0,
    sub      = length(split("/", var.assignment_scope)) == 3 ? 1 : 0,
    rg       = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) < 1 ? length(split("/", var.assignment_scope)) == 5 ? 1 : 0 : 0,
    resource = length(split("/", var.assignment_scope)) >= 6 ? 1 : 0,
  })

  # evaluate remediation scope from resource identifier
  resource_discovery_mode = var.re_evaluate_compliance == true ? "ReEvaluateCompliance" : "ExistingNonCompliant"
  remediation_scope       = try(coalesce(var.remediation_scope, var.assignment_scope), "")
  remediate = try({
    mg       = length(regexall("(\\/managementGroups\\/)", local.remediation_scope)) > 0 ? 1 : 0,
    sub      = length(split("/", local.remediation_scope)) == 3 ? 1 : 0,
    rg       = length(regexall("(\\/managementGroups\\/)", local.remediation_scope)) < 1 ? length(split("/", local.remediation_scope)) == 5 ? 1 : 0 : 0,
    resource = length(split("/", local.remediation_scope)) >= 6 ? 1 : 0,
  })

  # evaluate assignment outputs
  assignment = try(
    azurerm_management_group_policy_assignment.def[0],
    azurerm_subscription_policy_assignment.def[0],
    azurerm_resource_group_policy_assignment.def[0],
    azurerm_resource_policy_assignment.def[0],
  "")
  remediation_id = try(
    azurerm_management_group_policy_remediation.rem[0].id,
    azurerm_subscription_policy_remediation.rem[0].id,
    azurerm_resource_group_policy_remediation.rem[0].id,
    azurerm_resource_policy_remediation.rem[0].id,
  "")
}