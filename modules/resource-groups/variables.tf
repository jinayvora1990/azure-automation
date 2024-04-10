variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = string
}

variable "location" {
  description = "(Optional) Azure Location"
  type        = string
  default     = "uaenorth"
}

variable "tags" {
  description = "(Optional) Resource Tags"
  type        = map(string)
  default     = {}
}
