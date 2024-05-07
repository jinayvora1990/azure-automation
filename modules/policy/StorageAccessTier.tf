resource "azurerm_policy_definition" "no_cool_storage_policy" {
  name         = "noCoolStoragePolicy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Disallow Cool Access Tier Storage Accounts"
  metadata     = <<METADATA
    {
      "category": "Storage"
    }
  METADATA
  policy_rule  = file("${path.module}/policies/storageAccount/accessTier/policy-rule.json")
  parameters   = file("${path.module}/policies/storageAccount/accessTier/policy-parameters.json")
}

resource "azurerm_resource_group_policy_assignment" "no_cool_storage_assignment" {
  name                 = "noCoolStorageAssignment"
  resource_group_id    = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg"
  policy_definition_id = azurerm_policy_definition.no_cool_storage_policy.id

  parameters = <<PARAMETERS
    {
      "allowedAccessTiers": {
        "value": ["Hot", "Cool"]
      }
    }
  PARAMETERS
}


#  policy_rule = <<POLICY_RULE
#    {
#      "if": {
#        "allOf": [
#          {
#            "field": "type",
#            "equals": "Microsoft.Storage/storageAccounts"
#          },
#          {
#            "not": {
#              "field": "Microsoft.Storage/storageAccounts/accessTier",
#              "in": "[parameters('allowedAccessTiers')]"
#            }
#          }
#        ]
#      },
#      "then": {
#        "effect": "deny"
#      }
#    }
#  POLICY_RULE
#
#  parameters = <<PARAMETERS
#    {
#    "allowedAccessTiers": {
#      "type": "Array",
#      "metadata": {
#        "description": "The list of allowed Access Tier for Storage Account.",
#        "displayName": "Allowed Access Tier for Storage Account"
#      }
#    }
#  }
#PARAMETERS
