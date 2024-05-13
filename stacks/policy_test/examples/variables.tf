
variable "policy_details" {
  type = map(object({
    policy_name           = string
    assignment_effect     = string
    assignment_parameters = any
  }))
  default = {

  }
}
