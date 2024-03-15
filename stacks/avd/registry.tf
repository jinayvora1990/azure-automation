module "container_registry" {
  source = "../../modules/container-registry"

  registry_name               = "adcbcontregistryadagasg"
  registry_sku                = "Premium"
  resource_group_name         = "example-resources"
  resource_location           = "uaenorth"
  user_assigned_identity_name = "registry-uai"
}