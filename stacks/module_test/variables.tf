variable "location" {
  type        = string
  description = "location of resource group"
  default     = "uaenorth"
}

variable "environment" {
  type        = string
  description = "Environment where resource to be deployed"
  default     = "dev"
}

variable "application_name" {
  type        = string
  description = "Name of application project shortcode"
  default     = "cibg"
}



variable "policy_details" {
  type = map(object({
    assignment_effect     = string
    assignment_parameters = any
  }))
  default = {}
}
