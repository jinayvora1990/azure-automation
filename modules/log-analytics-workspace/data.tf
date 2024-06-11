data "azuread_application" "applications" {
  count        = length(var.contributor_apps)
  display_name = var.contributor_apps[count.index]
}

data "azuread_user" "users" {
  count               = length(var.contributor_users)
  user_principal_name = var.contributor_users[count.index]
}