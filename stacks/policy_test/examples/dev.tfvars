policy_details = {
  deny_azure_regions = {
    assignment_effect = "Deny"
    assignment_parameters = {
      listOfRegionsAllowed = ["uaenorth", "uswest"]
    }
  },
  deny_storage_sku = {
    assignment_effect = "Deny"
    assignment_parameters = {
      allowedSku = ["Standard_LRS", "Standard_GRS"]
    }
  }
}
