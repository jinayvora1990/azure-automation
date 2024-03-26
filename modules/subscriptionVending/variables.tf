
variable "subscription_name" {
  description = "(Required) The Name of the Subscription. This is the Display Name in the portal."
  type        = string
}

variable "enrollment_account_name" {
  description = "(Required) Name of the Enrollment Account"
  type        = string
}

variable "billing_account_name" {
  description = "(Required) Name of the billing account"
  type        = string
}

variable "azure_mgmt_group" {
  description = "(Required) Name of the Management Group where subscription needs to be created"
  type        = string
}
