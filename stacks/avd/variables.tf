variable "rg_name" {
  description = "(Required) Name of the resource group"
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

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = null
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = null
}

variable "subscription_name" {
  description = "The Name of the Subscription. This is the Display Name in the portal."
  type        = string
  default     = null
}

variable "enrollment_account_name" {
  description = "Name of the Enrollment Account"
  type        = string
  default     = null
}

variable "billing_account_name" {
  description = "Name of the billing account"
  type        = string
  default     = null
}

variable "azure_mgmt_group" {
  description = "Name of the Management Group where subscription needs to be created"
  type        = string
  default     = null
}
