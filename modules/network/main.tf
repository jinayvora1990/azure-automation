#resource "azurerm_resource_group" "avd" {
#  provider = azurerm.avd
#  name     = "rg-vnet-avd-prod-uaenorth-01"
#  location = "uaenorth"
#}
#resource "azurerm_virtual_network" "avd" {
#  provider            = azurerm.avd
#  name                = "vnet-avd-uaenorth-01"
#  location            = azurerm_resource_group.avd.location
#  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
#  address_space       = ["xxx.xxx8.0/22"]
#  dns_servers         = ["xxx.xxx6.4", "xxx.xxx6.5"]
#}
#
##Create Peering to Hub
#resource "azurerm_virtual_network_peering" "peer-avd-to-Hub" {
#  provider                     = azurerm.avd
#  name                         = "peer-avd-to-Hub"
#  resource_group_name          = "rg-vnet-avd-prod-uaenorth-01"
#  virtual_network_name         = "vnet-avd-uaenorth-01"
#  remote_virtual_network_id    = "/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-hub-uaenorth-01/providers/Microsoft.Network/virtualNetworks/vnet-connectivity-hub-uaenorth-01"
#  allow_virtual_network_access = true
#  allow_forwarded_traffic      = true
#  allow_gateway_transit        = true
#  use_remote_gateways          = true
#}
#
#resource "azurerm_subnet" "avd_subnet" {
#  provider                                  = azurerm.avd
#  name                                      = "snet-avd-prod-uaenorth-001"
#  resource_group_name                       = "rg-vnet-avd-prod-uaenorth-01"
#  virtual_network_name                      = "vnet-avd-uaenorth-01"
#  address_prefixes                          = ["xxx.xxx8.0/24"]
#  private_endpoint_network_policies_enabled = false
#  depends_on                                = [azurerm_network_security_group.avd_nsg]
#}
#
#resource "azurerm_subnet" "w365_subnet" {
#  provider                                  = azurerm.avd
#  name                                      = "snet-w365-prod-uaenorth-001"
#  resource_group_name                       = "rg-vnet-avd-prod-uaenorth-01"
#  virtual_network_name                      = "vnet-avd-uaenorth-01"
#  address_prefixes                          = ["xxx.xxx9.0/24"]
#  private_endpoint_network_policies_enabled = false
#  depends_on                                = [azurerm_network_security_group.avd_nsg]
#}
#
#resource "azurerm_subnet" "private_endpoint_subnet" {
#  provider                                  = azurerm.avd
#  name                                      = "snet-pe-prod-uaenorth-001"
#  resource_group_name                       = azurerm_resource_group.avd.name
#  virtual_network_name                      = azurerm_virtual_network.avd.name
#  address_prefixes                          = ["xxx.xxx11.224/27"]
#  private_endpoint_network_policies_enabled = true
#  depends_on                                = [azurerm_virtual_network.avd]
#}
#
#resource "azurerm_network_security_group" "avd_pe_nsg" {
#  provider            = azurerm.avd
#  location            = "uaenorth"
#  name                = "nsg-snet-pe-prod-uaenorth-001"
#  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
#}
#
#resource "azurerm_network_security_group" "avd_nsg" {
#  provider            = azurerm.avd
#  location            = "uaenorth"
#  name                = "nsg-snet-avd-prod-uaenorth-001"
#  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
#
#  security_rule {
#    name                       = "Inbound-DC-Tcp-Communication"
#    priority                   = 101
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefixes    = ["xxx.xxx6.4", "xxx.xxx6.5"]
#    destination_address_prefix = "*"
#  }
#  security_rule {
#    name                       = "Inbound-DC-Udp-Communication"
#    priority                   = 102
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Udp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefixes    = ["xxx.xxx6.4", "xxx.xxx6.5"]
#    destination_address_prefix = "*"
#  }
#
#  security_rule {
#    name                   = "Allow-OnPrem-Inbound-Communication"
#    priority               = 104
#    direction              = "Inbound"
#    access                 = "Allow"
#    protocol               = "*"
#    source_port_range      = "*"
#    destination_port_range = "*"
#    source_address_prefixes = ["xxx.xxx.xxx.60", "xxx.xxx.125.133", "xxx.xxx.125.133", "xxx.xxx.xxx.184",
#      "xxx.xxx.xxx.188", "xxx.xxx.xxx.182", "xxx.xxx.xxx.184", "xxx.xxx.xxx.188",
#      "xxx.xxx.xxx.181", "xxx.xxx.xxx.183", "xxx.xxx.xxx.183", "xxx.xxx.xxx.196",
#      "xxx.xxx.xxx.205"
#    ]
#    destination_address_prefix = "*"
#  }
#
#  #Adding Manual Blocks for AVD NSG Inbound Rules - START
#
#  security_rule {
#    name                         = "Allow-OnPrem-to-AVD-Subnet-RDP-TCP"
#    priority                     = 100
#    direction                    = "Inbound"
#    access                       = "Allow"
#    protocol                     = "Tcp"
#    source_port_range            = "*"
#    destination_port_range       = "3389"
#    source_address_prefixes      = ["xxx.xxx.xxx0/23", "xxx.xxx.xxx0/23"]
#    destination_address_prefixes = ["xxx.xxx8.0/22"]
#    description                  = "CRQ000000146541,CRQ000000146728,CRQ000000147705"
#  }
#  security_rule {
#    name                       = "Allow-OnPrem-to-AVD-Subnet-RDP-UDP"
#    priority                   = 150
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Udp"
#    source_port_range          = "*"
#    destination_port_range     = "3389"
#    source_address_prefixes    = ["xxx.xxx.xxx0/23", "xxx.xxx.xxx0/23"]
#    destination_address_prefix = "*"
#    description                = "CRQ000000146541,CRQ000000146728,CRQ000000147705"
#  }
#  security_rule {
#    name                         = "Allow-PrivateCidrBlock-to-AVD-Subnet-ICMP"
#    priority                     = 205
#    direction                    = "Inbound"
#    access                       = "Allow"
#    protocol                     = "Icmp"
#    source_port_range            = "*"
#    destination_port_range       = "*"
#    source_address_prefixes      = ["10.0.0.0/8"]
#    destination_address_prefixes = ["xxx.xxx8.0/22"]
#    description                  = "Allowing ICMP from Private Subnets to AVD Subnet"
#  }
#  #Adding Manual Blocks for AVD NSG Inbound Rules - END
#  security_rule {
#    name                         = "Outbound-DC-Tcp-Communication"
#    priority                     = 101
#    direction                    = "Outbound"
#    access                       = "Allow"
#    protocol                     = "Tcp"
#    source_port_range            = "*"
#    destination_port_range       = "*"
#    source_address_prefix        = "*"
#    destination_address_prefixes = ["xxx.xxx6.4", "xxx.xxx6.5"]
#  }
#  security_rule {
#    name                         = "Outbound-DC-Udp-Communication"
#    priority                     = 102
#    direction                    = "Outbound"
#    access                       = "Allow"
#    protocol                     = "Udp"
#    source_port_range            = "*"
#    destination_port_range       = "*"
#    source_address_prefix        = "*"
#    destination_address_prefixes = ["xxx.xxx6.4", "xxx.xxx6.5"]
#  }
#  security_rule {
#    name                   = "Allow-OnPrem-Outbound-Communication"
#    priority               = 103
#    direction              = "Outbound"
#    access                 = "Allow"
#    protocol               = "*"
#    source_port_range      = "*"
#    destination_port_range = "*"
#    source_address_prefix  = "*"
#    destination_address_prefixes = ["xxx.xxx.xxx.60", "xxx.xxx.125.133", "xxx.xxx.125.133", "xxx.xxx.xxx.184",
#      "xxx.xxx.xxx.188", "xxx.xxx.xxx.182", "xxx.xxx.xxx.184", "xxx.xxx.xxx.188",
#      "xxx.xxx.xxx.181", "xxx.xxx.xxx.183", "xxx.xxx.xxx.183", "xxx.xxx.xxx.196",
#      "xxx.xxx.xxx.205"
#    ]
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "AzureCloud"
#    destination_port_range     = "8443"
#    direction                  = "Outbound"
#    name                       = "AzureCloud"
#    priority                   = 110
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "AzureFrontDoor.Frontend"
#    destination_port_range     = "443"
#    direction                  = "Outbound"
#    name                       = "AzureMarketplace"
#    priority                   = 130
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#
#  /*
#  security_rule {
#    access                     = "Deny"
#    destination_address_prefix = "*"
#    destination_port_range     = "*"
#    direction                  = "Inbound"
#    name                       = "DenyALL"
#    priority                   = 4096
#    protocol                   = "*"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#*/
#
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "xxx.xxx.169.254"
#    destination_port_range     = "80"
#    direction                  = "Outbound"
#    name                       = "AzureInstanceMetadata"
#    priority                   = 150
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "AzureMonitor"
#    destination_port_range     = "443"
#    direction                  = "Outbound"
#    name                       = "AzureMonitor"
#    priority                   = 120
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "WindowsVirtualDesktop"
#    destination_port_range     = "443"
#    direction                  = "Outbound"
#    name                       = "AVDServiceTraffic"
#    priority                   = 100
#    protocol                   = "*"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "Internet"
#    destination_port_ranges    = ["1688", "443", "80", "5671"]
#    direction                  = "Outbound"
#    name                       = "WindowsActivation"
#    priority                   = 140
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "xxx.xxx.106.81"
#    destination_port_range     = "443"
#    direction                  = "Outbound"
#    name                       = "MY_ADCB"
#    priority                   = 141
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "xxx.xxx..0.0/16"
#    destination_port_range     = "3478"
#    direction                  = "Outbound"
#    name                       = "TURN"
#    priority                   = 142
#    protocol                   = "Udp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "xxx.xxx.129.16"
#    destination_port_range     = "80"
#    direction                  = "Outbound"
#    name                       = "Azure-HC"
#    priority                   = 143
#    protocol                   = "Tcp"
#    source_address_prefix      = "*"
#    source_port_range          = "*"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.46", "xxx.xxx.xxx.57"]
#    destination_port_ranges      = ["5012", "515", "9100"]
#    direction                    = "Outbound"
#    name                         = "SafeQ-Printer"
#    priority                     = 144
#    protocol                     = "Tcp"
#    source_address_prefix        = "*"
#    source_port_range            = "*"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.115", "xxx.xxx.xxx.116"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "Imprivata"
#    priority                     = 145
#    protocol                     = "Tcp"
#    source_address_prefix        = "*"
#    source_port_range            = "*"
#  }
#
#  #Adding Manual Blocks for AVD NSG Outbound Rules - START
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.46", "xxx.xxx.xxx.57"]
#    destination_port_ranges      = ["5012", "515", "9100"]
#    direction                    = "Outbound"
#    name                         = "SafeQ-Printer-Rules"
#    priority                     = 155
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000147705"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.106.81", "xxx.xxx.xxx.115", "xxx.xxx.xxx.116"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "MyADCB-Imprivata"
#    priority                     = 160
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000147705"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "CRQ000000146541"
#    priority                     = 170
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000146541"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15"]
#    destination_port_ranges      = ["3478", "3479", "3480", "3481"]
#    direction                    = "Outbound"
#    name                         = "CRQ000000146541-1"
#    priority                     = 175
#    protocol                     = "Udp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000146541"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15", "xxx.xxx..119.141/32", "xxx.xxx..160.207/32"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "CRQ000000146541-3"
#    priority                     = 185
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000146541"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15", "xxx.xxx..119.141/32", "xxx.xxx..160.207/32"]
#    destination_port_range       = "80"
#    direction                    = "Outbound"
#    name                         = "CRQ000000146541-4"
#    priority                     = 195
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000146541"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.205"]
#    destination_port_range       = "445"
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-ADCNS10"
#    priority                     = 215
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000146541-9"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.53", "xxx.xxx.xxx.54", "xxx.xxx.111.212"]
#    destination_port_ranges      = ["80", "443"]
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-ADCBProxy"
#    priority                     = 225
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000151693"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.xxx.60"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-ADCBProxy-1"
#    priority                     = 235
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000151693"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.0.0/16", "xxx.xxx.0.0/16"]
#    destination_port_range       = "443"
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-OnPremise-applications"
#    priority                     = 245
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000151479"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.112.111", "xxx.xxx.112.112", "xxx.xxx.112.113", "xxx.xxx.112.123", "xxx.xxx.112.116"]
#    destination_port_ranges      = ["8080", "9080", "9443"]
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-LendPerfect-App"
#    priority                     = 255
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000151479"
#  }
#  security_rule {
#    access                       = "Allow"
#    destination_address_prefixes = ["xxx.xxx.110.178", "xxx.xxx.110.240", "xxx.xxx.110.241", "xxx.xxx.110.246", "xxx.xxx.110.242"]
#    destination_port_ranges      = ["99", "88"]
#    direction                    = "Outbound"
#    name                         = "Avdsubnet-to-appzone-App"
#    priority                     = 265
#    protocol                     = "Tcp"
#    source_address_prefixes      = ["xxx.xxx8.0/22"]
#    source_port_range            = "*"
#    description                  = "CRQ000000151479"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "Internet"
#    destination_port_range     = "443"
#    direction                  = "Outbound"
#    name                       = "Avdsubnet-to-internet-over-443"
#    priority                   = 275
#    protocol                   = "*"
#    source_address_prefixes    = ["xxx.xxx8.0/22"]
#    source_port_range          = "*"
#    description                = "CRQ000000151868"
#  }
#  security_rule {
#    access                     = "Allow"
#    destination_address_prefix = "Internet"
#    destination_port_range     = "80"
#    direction                  = "Outbound"
#    name                       = "Avdsubnet-to-internet-over-80"
#    priority                   = 285
#    protocol                   = "Tcp"
#    source_address_prefixes    = ["xxx.xxx8.0/22"]
#    source_port_range          = "*"
#    description                = "CRQ000000151868"
#  }
#
#  #Adding Manual Blocks for AVD NSG Outbound Rules - END
#}
#
#resource "azurerm_subnet_network_security_group_association" "nsg_avd_assoc" {
#  provider                  = azurerm.avd
#  subnet_id                 = azurerm_subnet.avd_subnet.id
#  network_security_group_id = azurerm_network_security_group.avd_nsg.id
#  depends_on = [
#    azurerm_subnet.avd_subnet
#  ]
#}
#
#resource "azurerm_subnet_network_security_group_association" "nsg_w365_assoc" {
#  provider                  = azurerm.avd
#  subnet_id                 = azurerm_subnet.w365_subnet.id
#  network_security_group_id = azurerm_network_security_group.avd_nsg.id
#  depends_on = [
#    azurerm_subnet.w365_subnet
#  ]
#}
#
#resource "azurerm_subnet_network_security_group_association" "nsg_pe_assoc" {
#  provider                  = azurerm.avd
#  subnet_id                 = azurerm_subnet.private_endpoint_subnet.id
#  network_security_group_id = azurerm_network_security_group.avd_pe_nsg.id
#}
#
#resource "azurerm_route_table" "udr" {
#  provider                      = azurerm.avd
#  name                          = "route-snet-avd-prod-uaenorth-001"
#  location                      = "uaenorth"
#  resource_group_name           = "rg-vnet-avd-prod-uaenorth-01"
#  disable_bgp_route_propagation = true
#
#  route {
#    name                   = "udr-to-fw"
#    address_prefix         = "0.0.0.0/0"
#    next_hop_type          = "VirtualAppliance"
#    next_hop_in_ip_address = "xxx.xxx1.4"
#  }
#}
#
#resource "azurerm_subnet_route_table_association" "udr_avd_asso" {
#  provider       = azurerm.avd
#  subnet_id      = azurerm_subnet.avd_subnet.id
#  route_table_id = azurerm_route_table.udr.id
#}
#
#resource "azurerm_subnet_route_table_association" "udr_w365_asso" {
#  provider       = azurerm.avd
#  subnet_id      = azurerm_subnet.w365_subnet.id
#  route_table_id = azurerm_route_table.udr.id
#}
#
#resource "azurerm_subnet_route_table_association" "udr_pesubnet_asso" {
#  provider       = azurerm.avd
#  subnet_id      = azurerm_subnet.private_endpoint_subnet.id
#  route_table_id = azurerm_route_table.udr.id
#  depends_on     = [azurerm_subnet.private_endpoint_subnet]
#}
#
#
## Resource group for shared services
#resource "azurerm_resource_group" "rg_shared" {
#  provider = azurerm.avd
#  name     = "rg-shared-avd-prod-uaenorth-01"
#  location = "uaenorth"
#}
#
## Resource group for storage related services
#resource "azurerm_resource_group" "rg_storage" {
#  provider = azurerm.avd
#  name     = "rg-storage-avd-prod-uaenorth-01"
#  location = "uaenorth"
#}
#
### Create a File Storage Account
#resource "azurerm_storage_account" "storage" {
#  provider            = azurerm.avd
#  name                = "saavdproduaenorth01"
#  resource_group_name = azurerm_resource_group.rg_storage.name
#  location            = azurerm_resource_group.rg_storage.location
#  #public_network_access_enabled = false
#  min_tls_version          = "TLS1_2"
#  account_tier             = "Premium"
#  account_replication_type = "LRS"
#  account_kind             = "FileStorage"
#
#  identity {
#    type = "SystemAssigned"
#  }
#}
#/*
#resource "azurerm_storage_share" "FSShare" {
#  provider         = azurerm.avd
#  name             = "fsavdprod01"
#  quota            = "100"
#  enabled_protocol = "SMB"
#  storage_account_name = azurerm_storage_account.storage.name
#  depends_on           = [azurerm_storage_account.storage]
#}
#*/
#
#resource "azurerm_private_endpoint" "afpe" {
#  provider            = azurerm.avd
#  name                = "pe-saavdproduaenorth01-file"
#  location            = azurerm_resource_group.rg_storage.location
#  resource_group_name = azurerm_resource_group.rg_storage.name
#  subnet_id           = azurerm_subnet.private_endpoint_subnet.id
#
#  private_service_connection {
#    name                           = "psc-file-01"
#    private_connection_resource_id = azurerm_storage_account.storage.id
#    is_manual_connection           = false
#    subresource_names              = ["file"]
#  }
#  private_dns_zone_group {
#
#    name                 = "dns-file-01"
#    private_dns_zone_ids = ["/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-dns-uaenorth-01/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]
#  }
#}
#/*
## Deny Traffic from Public Networks with white list exceptions
#resource "azurerm_storage_account_network_rules" "stfw" {
#  provider           = azurerm.avd
#  storage_account_id = azurerm_storage_account.storage.id
#  default_action     = "Deny"
#  bypass             = ["AzureServices", "Metrics", "Logging"]
#  depends_on = [azurerm_storage_share.FSShare,
#    azurerm_private_endpoint.afpe]
#}
#*/
#
#resource "azurerm_storage_account" "avd_image_storage" {
#  provider                 = azurerm.avd
#  name                     = "saavdimagesprod001"
#  resource_group_name      = azurerm_resource_group.rg_storage.name
#  location                 = azurerm_resource_group.rg_storage.location
#  account_tier             = "Premium"
#  account_replication_type = "LRS"
#}
#/*
#resource "azurerm_storage_container" "avd_image_storage_container" {
#  provider 				= azurerm.avd
#  name                  = "images"
#  storage_account_name  = azurerm_storage_account.avd_image_storage.name
#  #container_access_type = "private"
#}
#*/
#resource "azurerm_private_endpoint" "blob_pe" {
#  provider            = azurerm.avd
#  name                = "pe-saavdimagesprod01-blob"
#  location            = azurerm_resource_group.rg_storage.location
#  resource_group_name = azurerm_resource_group.rg_storage.name
#  subnet_id           = azurerm_subnet.private_endpoint_subnet.id
#
#
#  private_service_connection {
#    name                           = "psc-blob-01"
#    private_connection_resource_id = azurerm_storage_account.avd_image_storage.id
#    is_manual_connection           = false
#    subresource_names              = ["blob"]
#  }
#  private_dns_zone_group {
#    name                 = "dns-blob-01"
#    private_dns_zone_ids = ["/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-dns-uaenorth-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
#  }
#}
#
## Resource group for key management related services
#resource "azurerm_resource_group" "rg_kv" {
#  provider = azurerm.avd
#  name     = "rg-akv-avd-prod-uaenorth-01"
#  location = "uaenorth"
#}
#/*
#resource "azurerm_key_vault" "kv" {
#  provider 				   = azurerm.avd
#  name                     = "kv-avd-prod-uaenorth-01"
#  tenant_id                = "6171e1a1-b822-451c-b9bb-e6e35d88b0db"
#  location                 = azurerm_resource_group.rg_kv.location
#  resource_group_name      = azurerm_resource_group.rg_kv.name
#  public_network_access_enabled = true
#  enable_rbac_authorization = true
#  sku_name                 = "standard"
#  purge_protection_enabled = true
#
#
#  depends_on = [
#    azurerm_resource_group.rg_kv]
#
#  /*network_acls {
#    default_action = "Deny"
#    bypass         = "AzureServices"
#	#ip_rules       = ["xxx.xxx0.0/16"]
#  }
#}
#
#resource "azurerm_private_endpoint" "kvpe" {
#  provider 			  = azurerm.avd
#  name                = "pe-kv-avd-prod-uaenorth-01"
#  location            = azurerm_resource_group.rg_kv.location
#  resource_group_name = azurerm_resource_group.rg_kv.name
#  subnet_id           = azurerm_subnet.private_endpoint_subnet.id
#
#  private_service_connection {
#    name                           = "psc-kv-01"
#    private_connection_resource_id = azurerm_key_vault.kv.id
#    is_manual_connection           = false
#    subresource_names              = ["Vault"]
#  }
#  depends_on = [
#    azurerm_key_vault.kv
#  ]
#  private_dns_zone_group {
#    name                 = "dns-kv-01"
#    private_dns_zone_ids = ["/subscriptions/6fa47cb8-1205-49a2-aa48-e35dfec6d698/resourceGroups/rg-connectivity-dns-uaenorth-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
#  }
#}
#*/
