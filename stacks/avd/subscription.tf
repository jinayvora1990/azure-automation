module "avd_subscription" {
  source = "../../modules/subscriptionVending"

  count = var.subscription_name != null ? 1 : 0

  subscription_name       = var.subscription_name
  enrollment_account_name = var.enrollment_account_name
  billing_account_name    = var.billing_account_name
  azure_mgmt_group        = var.azure_mgmt_group
}