variable "app_name" {
  description = "(Required) Name of the application"
  type        = string
}

variable "rg_name" {
  description = "(Required) Name of Resource Groups to create"
  type        = list(string)
  default = ["aks-test-rg01"]
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
  default = [
    {
      name           = "example_storage_account"
      resource_group = "aks-test-rg"
      containers     = [
        {
          name        = "example-container"
          access_type = "private"
        }
      ]
      skuname = "Standard_LRS"
    }]
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

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  default = "aks-test-rg"
}

variable "location" {
  description = "The name of the location to create the resources in."
  type        = string
  default = "uaenorth"
}

variable "sku" {
  default = "PerGB2018"
}
