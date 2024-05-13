
variable "policy_details" {
  type = map(object({
    assignment_effect     = string
    assignment_parameters = any
  }))
  default = {}
}
