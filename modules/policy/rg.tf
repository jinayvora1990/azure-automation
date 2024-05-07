resource "azurerm_policy_definition" "enforce_region_policy" {
  name         = "enforceRegionPolicy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce region policy definition"

  metadata = <<METADATA
    {
      "category": "Resource Management"
    }
  METADATA

  policy_rule = file("${path.module}/policies/resource-location/policy-rule.json")
  parameters  = file("${path.module}/policies/resource-location/policy-parameters.json")
}

resource "azurerm_resource_group_policy_assignment" "enforce_region_assignment" {
  name                 = "enforceRegionAssignment"
  resource_group_id    = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg"
  policy_definition_id = azurerm_policy_definition.enforce_region_policy.id
  parameters           = <<PARAMETERS
    {
      "allowedLocations": {
        "value": ["uaenorth"]
      }
    }
  PARAMETERS
}
