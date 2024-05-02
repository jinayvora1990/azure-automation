resource "tls_private_key" "pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-${var.application_name}-${local.environment}-${local.region_shortcode}-1"
  location            = local.location
  resource_group_name = var.resource_group_name

  kubernetes_version                  = var.kubernetes_version == "" ? null : var.kubernetes_version
  dns_prefix                          = var.aks_name_suffix
  automatic_channel_upgrade           = var.automatic_channel_upgrade
  sku_tier                            = var.aks_sku_tier
  local_account_disabled              = !var.enable_local_account
  workload_identity_enabled           = var.workload_identity_enabled
  oidc_issuer_enabled                 = var.workload_identity_enabled ? true : var.oidc_issuer_enabled
  private_cluster_enabled             = var.enable_private_cluster
  private_cluster_public_fqdn_enabled = var.enable_private_cluster_public_fqdn
  private_dns_zone_id                 = var.enable_private_cluster ? local.aks_private_dns_zone_id : null
  role_based_access_control_enabled   = true
  node_resource_group                 = var.node_resource_group_name
  azure_policy_enabled                = var.enable_azure_policy

  default_node_pool {
    name                         = var.aks_default_node_pool_name
    temporary_name_for_rotation  = "${var.aks_default_node_pool_name}tmp"
    node_count                   = var.aks_agent_count
    orchestrator_version         = var.kubernetes_version == "" ? null : var.kubernetes_version
    vm_size                      = var.aks_vm_size
    zones                        = var.availability_zones
    type                         = "VirtualMachineScaleSets"
    enable_auto_scaling          = var.aks_enable_auto_scaling
    enable_node_public_ip        = false
    min_count                    = var.aks_node_count_min
    max_count                    = var.aks_node_count_max
    max_pods                     = var.aks_node_max_pods
    os_disk_type                 = var.aks_os_disk_type
    os_disk_size_gb              = var.aks_node_os_disk_size_gb
    only_critical_addons_enabled = var.only_critical_addons_enabled
    vnet_subnet_id               = data.azurerm_subnet.aks_subnet.id
    tags                         = var.tags
    ultra_ssd_enabled            = var.aks_node_ultra_ssd_enabled
    upgrade_settings {
      max_surge = var.max_surge
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = tls_private_key.pair.public_key_openssh
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count, tags["creator"], tags["created_on"]
    ]
  }

  network_profile {
    network_plugin    = var.aks_network_plugin
    network_policy    = "calico"
    dns_service_ip    = var.aks_dns_ip
    pod_cidr          = var.aks_network_plugin == "kubenet" ? var.aks_pod_cidr : null
    service_cidr      = var.aks_service_cidr
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  dynamic "api_server_access_profile" {
    for_each = toset(length(var.api_server_authorized_ip_ranges) != 0 ? [{}] : [])
    content {
      authorized_ip_ranges     = var.api_server_authorized_ip_ranges
      vnet_integration_enabled = false
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window == null ? [] : [{}]

    content {
      dynamic "allowed" {
        for_each = var.maintenance_window.allowed

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }

      dynamic "not_allowed" {
        for_each = var.maintenance_window.not_allowed

        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = local.oms_agent_block_enabled
    content {
      log_analytics_workspace_id = var.oms_agent_log_analytics_workspace_id
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.enable_kubelet_identity ? [{}] : []
    content {
      client_id                 = azurerm_user_assigned_identity.kubelet[0].client_id
      object_id                 = azurerm_user_assigned_identity.kubelet[0].principal_id
      user_assigned_identity_id = azurerm_user_assigned_identity.kubelet[0].id
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.enable_azure_key_vault_secrets_provider ? [{}] : []
    content {
      secret_rotation_enabled  = var.enable_azure_key_vaults_secrets_rotation
      secret_rotation_interval = var.azure_key_vaults_secrets_rotation_interval
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_managed ? [{}] : []

    content {
      managed                = true
      admin_group_object_ids = var.azure_active_directory_admin_group_object_ids
      azure_rbac_enabled     = var.azure_active_directory_rbac_enabled
      tenant_id              = local.tenant_id
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "regular_node_pools" {
  count = length(var.regular_node_pools)
  name  = var.regular_node_pools[count.index].name

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id

  zones                 = var.regular_node_pools[count.index].availability_zones
  enable_auto_scaling   = var.regular_node_pools[count.index].enable_auto_scaling
  enable_node_public_ip = false

  priority    = "Regular"
  node_taints = var.regular_node_pools[count.index].node_taints

  mode                 = var.regular_node_pools[count.index].mode
  node_labels          = var.regular_node_pools[count.index].node_labels
  orchestrator_version = var.regular_node_pools[count.index].kubernetes_version == "" ? null : var.regular_node_pools[count.index].kubernetes_version

  os_disk_type    = var.regular_node_pools[count.index].os_disk_type
  os_disk_size_gb = var.regular_node_pools[count.index].os_disk_size_gb
  vm_size         = var.regular_node_pools[count.index].vm_size

  vnet_subnet_id    = data.azurerm_subnet.aks_subnet.id
  max_count         = var.regular_node_pools[count.index].max_count
  min_count         = var.regular_node_pools[count.index].min_count
  node_count        = var.regular_node_pools[count.index].node_count
  max_pods          = var.regular_node_pools[count.index].max_pods
  ultra_ssd_enabled = var.regular_node_pools[count.index].ultra_ssd_enabled

  lifecycle {
    ignore_changes = [node_count, tags["creator"]]
  }

  tags = var.tags

  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name != null ? each.value.name : "diag-aks-${local.environment}"
  target_resource_id             = azurerm_kubernetes_cluster.aks_cluster.id
  eventhub_authorization_rule_id = each.value.event_hub_authorization_rule_resource_id
  eventhub_name                  = each.value.event_hub_name
  log_analytics_destination_type = each.value.log_analytics_destination_type
  log_analytics_workspace_id     = each.value.workspace_resource_id
  partner_solution_id            = each.value.marketplace_partner_resource_id
  storage_account_id             = each.value.storage_account_resource_id

  dynamic "enabled_log" {
    for_each = each.value.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = each.value.metric_categories
    content {
      category = metric.value
    }
  }
}