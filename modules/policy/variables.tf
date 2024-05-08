#
#
#variable "service_name" {
#  description = "Azure service name which is affected by policy"
#  default     = null
#  type        = string
#}
#
#variable "policy_name" {
#  description = "Azure Policy to be deployed"
#  default     = null
#  type        = string
#}
#
#
#
#
##
##variable "privatelink_subnet" {
##  type = object({
##    name           = string
##    vnet_name      = string
##    resource_group = string
##  })
##  description = "Subnet where the private link is required."
##  default     = null
##}