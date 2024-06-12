module "resource_group" {
  count   = var.provision_modules.rg ? 1 : 0
  source  = "../../modules/resource-groups"
  rg_name = format("rg-%s-%s-%s-%s", var.application_name, var.environment, var.location, module.res-id.result)
  tags    = local.tags
}





