policy_details = {
  example_policy_1 = {
    policy_name       = "deny_azure_regions"
    assignment_effect = "Deny"
    assignment_parameters = {
      listOfRegionsAllowed = ["uaenorth", "uswest"]
    }
  },
  example_policy_2 = {
    policy_name       = "deny_storage_sku"
    assignment_effect = "Deny"
    assignment_parameters = {
      allowedSku = ["Standard_LRS", "Standard_GRS"]
    }
  }
}
