variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = list(string)
}

variable "storage_accounts" {
  description = "Storage Account details"
  type = list(object({
    name           = string
    resource_group = string
    containers = list(object({
      name        = string
      access_type = string
    }))
    skuname = string
  }))
  default = []
}

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