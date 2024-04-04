variable "registry_name" {
  description = "Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created"
  type        = string
}

variable "registry_sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  type        = string
  default     = "Basic"
}

variable "user_assigned_identity_name" {
  description = "Name of the User Assigned Managed Identity"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  type        = string
  default     = "uaenorth"
}

variable "azurerm_key_vault_key" {
  description = "Specifies the name of the Key Vault Key. Changing this forces a new resource to be created."
  type        = string
}

variable "kv_name" {
  description = "The ID of the Key Vault where the Key should be created. Changing this forces a new resource to be created"
  type        = string
}