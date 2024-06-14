module "base-infra" {
  count  = var.provision_modules.network ? 1 : 0
  source = "../../modules/base-infrastructure"

  resource_group_name    = module.resource_group[0].rg_name
  app_name               = var.application_name
  environment            = local.environment
  vnet_address_spaces    = var.vnet_address_spaces
  dns_servers            = ["10.0.0.4", "10.0.0.5"]
  create_ddos_plan       = true
  create_network_watcher = false
  ddos_plan_name         = "DDOS-PP"
  subnets = {
    "subnet-1" : {
      subnet_name           = "subnet-1"
      subnet_address_prefix = ["10.0.0.0/25"]
      service_endpoints     = ["Microsoft.AzureCosmosDB"]
      nsg_inbound_rules = [
        ["test123", 100, "Inbound", "Deny", "Tcp", "*", "*", "*", "*"],
      ]
      nsg_outbound_rules = [
        ["testOut", 100, "Outbound", "Deny", "Udp", "*", "*", "*", "*"],
      ]
      route_table_rules = [
        #       ["rt_rule_1", "10.0.0.0/30", "VirtualAppliance", "VirtualAppliance"],
        ["rt_rule_2", "10.0.0.64/30", "VnetLocal", null]
      ]
    }
    "subnet-2" : {
      subnet_name           = "subnet-2"
      subnet_address_prefix = ["10.0.0.128/25"]
    }
    "subnet-3" : {
      subnet_name           = "subnet-3"
      subnet_address_prefix = ["10.0.1.0/24"]
    }
    "subnet-4" : {
      subnet_name           = "subnet-4"
      subnet_address_prefix = ["10.0.2.0/24"]
    }
  }
}

module "vnet-2" {
  count  = var.provision_modules.network ? 1 : 0
  source = "../../modules/base-infrastructure"

  resource_group_name = module.resource_group[0].rg_name
  app_name            = var.application_name
  environment         = local.environment
  vnet_address_spaces = var.vnet_address_spaces
  subnets             = var.subnets
}