#resource "azurerm_policy_definition" "standard_sku_storage_policy" {
#  name         = "standardSKUPolicy"
#  policy_type  = "Custom"
#  mode         = "All"
#  display_name = "allow Standard SKU Storage Accounts"
#
#  metadata = <<METADATA
#    {
#      "category": "Storage"
#    }
#  METADATA
#
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
#              "field": "Microsoft.Storage/storageAccounts/sku.name",
#              "equals": "Standard_LRS"
#            }
#          }
#        ]
#      },
#      "then": {
#        "effect": "deny"
#      }
#    }
#  POLICY_RULE
#}
#
#resource "azurerm_resource_group_policy_assignment" "standard_sku_storage_assignment" {
#  name                 = "StandardSKUAssignment"
#  resource_group_id    = "/subscriptions/e1811a95-7c51-4955-a86e-de0ce0c2cf73/resourceGroups/aks-test-rg"
#  policy_definition_id = azurerm_policy_definition.standard_sku_storage_policy.id
#}
