resource "azurerm_policy_definition" "no_cool_storage_policy" {
  name         = "noCoolStoragePolicy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Disallow Cool Access Tier Storage Accounts"

  metadata = <<METADATA
    {
      "category": "Storage"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Storage/storageAccounts"
          },
          {
            "not": {
              "field": "Microsoft.Storage/storageAccounts/accessTier",
              "equals": "Hot"
            }
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
  POLICY_RULE
}

resource "azurerm_resource_group_policy_assignment" "no_cool_storage_assignment" {
  name                 = "noCoolStorageAssignment"
  resource_group_id    = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg"
  policy_definition_id = azurerm_policy_definition.no_cool_storage_policy.id
}
