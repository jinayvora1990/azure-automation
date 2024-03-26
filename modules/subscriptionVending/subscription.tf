data "azurerm_billing_enrollment_account_scope" "billing_scope" {
  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.enrollment_account_name
}

data "azurerm_management_group" "mgmt_group" {
  name = var.azure_mgmt_group
}

resource "azurerm_subscription" "subscription" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.billing_scope.id
}

resource "azurerm_management_group_subscription_association" "subscription_mgmtgrp_assoc" {
  management_group_id = data.azurerm_management_group.mgmt_group.id
  subscription_id     = azurerm_subscription.subscription.id
}