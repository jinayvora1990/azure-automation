#variable "policy_name" {
#  type = map(any)
#  default = {
#    whitelist_regions = "Whitelist Azure Regions",
#    allowedsku = "Allowed Storage Account SKU"
#  }
#}
#

variable "policy_details" {
  type = map(object({
    policy_name           = string
    assignment_effect     = string
    assignment_parameters = any
  }))
  default = {
    example_policy_1 = {
      policy_name       = "whitelist_regions"
      assignment_effect = "Deny"
      assignment_parameters = {
        listOfRegionsAllowed = ["uaenorth", "uswest"]
      }
    }
  }
}
