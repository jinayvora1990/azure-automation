module "example_nsg" {
  source = "../../modules/network/"

  location            = "uaenorth"
  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"

  security_rules = [
    {
      name                       = "Inbound-DC-Tcp-Communication"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefixes    = ["xxx.xxx6.4", "xxx.xxx6.5"]
      destination_address_prefix = "*"
    },
    {
      name                       = "Inbound-DC-Udp-Communication"
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefixes    = ["xxx.xxx6.4", "xxx.xxx6.5"]
      destination_address_prefix = "*"
    },
    {
      name                   = "Allow-OnPrem-Inbound-Communication"
      priority               = 104
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "*"
      source_address_prefixes = ["xxx.xxx.xxx.60", "xxx.xxx.125.133", "xxx.xxx.125.133", "xxx.xxx.xxx.184",
        "xxx.xxx.xxx.188", "xxx.xxx.xxx.182", "xxx.xxx.xxx.184", "xxx.xxx.xxx.188",
        "xxx.xxx.xxx.181", "xxx.xxx.xxx.183", "xxx.xxx.xxx.183", "xxx.xxx.xxx.196",
        "xxx.xxx.xxx.205"
      ]
      destination_address_prefix = "*"
    },
    #Adding Manual Blocks for AVD NSG Inbound Rules - START
    {
      name                         = "Allow-OnPrem-to-AVD-Subnet-RDP-TCP"
      priority                     = 100
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "3389"
      source_address_prefixes      = ["xxx.xxx.xxx0/23", "xxx.xxx.xxx0/23"]
      destination_address_prefixes = ["xxx.xxx8.0/22"]
      description                  = "CRQ000000146541,CRQ000000146728,CRQ000000147705"
    },
    {
      name                       = "Allow-OnPrem-to-AVD-Subnet-RDP-UDP"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefixes    = ["xxx.xxx.xxx0/23", "xxx.xxx.xxx0/23"]
      destination_address_prefix = "*"
      description                = "CRQ000000146541,CRQ000000146728,CRQ000000147705"
    },
    {
      name                         = "Allow-PrivateCidrBlock-to-AVD-Subnet-ICMP"
      priority                     = 205
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Icmp"
      source_port_range            = "*"
      destination_port_range       = "*"
      source_address_prefixes      = ["10.0.0.0/8"]
      destination_address_prefixes = ["xxx.xxx8.0/22"]
      description                  = "Allowing ICMP from Private Subnets to AVD Subnet"
    },


    #Adding Manual Blocks for AVD NSG Inbound Rules - END
    {
      name                         = "Outbound-DC-Tcp-Communication"
      priority                     = 101
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "*"
      source_address_prefix        = "*"
      destination_address_prefixes = ["xxx.xxx6.4", "xxx.xxx6.5"]
    },
    {
      name                         = "Outbound-DC-Udp-Communication"
      priority                     = 102
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "Udp"
      source_port_range            = "*"
      destination_port_range       = "*"
      source_address_prefix        = "*"
      destination_address_prefixes = ["xxx.xxx6.4", "xxx.xxx6.5"]
    },
    {
      name                   = "Allow-OnPrem-Outbound-Communication"
      priority               = 103
      direction              = "Outbound"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "*"
      source_address_prefix  = "*"
      destination_address_prefixes = ["xxx.xxx.xxx.60", "xxx.xxx.125.133", "xxx.xxx.125.133", "xxx.xxx.xxx.184",
        "xxx.xxx.xxx.188", "xxx.xxx.xxx.182", "xxx.xxx.xxx.184", "xxx.xxx.xxx.188",
        "xxx.xxx.xxx.181", "xxx.xxx.xxx.183", "xxx.xxx.xxx.183", "xxx.xxx.xxx.196",
        "xxx.xxx.xxx.205"
      ]
    },
    {
      access                     = "Allow"
      destination_address_prefix = "AzureCloud"
      destination_port_range     = "8443"
      direction                  = "Outbound"
      name                       = "AzureCloud"
      priority                   = 110
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
    {
      access                     = "Allow"
      destination_address_prefix = "AzureFrontDoor.Frontend"
      destination_port_range     = "443"
      direction                  = "Outbound"
      name                       = "AzureMarketplace"
      priority                   = 130
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
    {
      access                     = "Allow"
      destination_address_prefix = "xxx.xxx.169.254"
      destination_port_range     = "80"
      direction                  = "Outbound"
      name                       = "AzureInstanceMetadata"
      priority                   = 150
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
    {
      access                     = "Allow"
      destination_address_prefix = "AzureMonitor"
      destination_port_range     = "443"
      direction                  = "Outbound"
      name                       = "AzureMonitor"
      priority                   = 120
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
    {
      access                     = "Allow"
      destination_address_prefix = "WindowsVirtualDesktop"
      destination_port_range     = "443"
      direction                  = "Outbound"
      name                       = "AVDServiceTraffic"
      priority                   = 100
      protocol                   = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["1688", "443", "80", "5671"]
      direction                  = "Outbound"
      name                       = "WindowsActivation"
      priority                   = 140
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "xxx.xxx.106.81"
      destination_port_range     = "443"
      direction                  = "Outbound"
      name                       = "MY_ADCB"
      priority                   = 141
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "xxx.xxx..0.0/16"
      destination_port_range     = "3478"
      direction                  = "Outbound"
      name                       = "TURN"
      priority                   = 142
      protocol                   = "Udp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "xxx.xxx.129.16"
      destination_port_range     = "80"
      direction                  = "Outbound"
      name                       = "Azure-HC"
      priority                   = 143
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.46", "xxx.xxx.xxx.57"]
      destination_port_ranges      = ["5012", "515", "9100"]
      direction                    = "Outbound"
      name                         = "SafeQ-Printer"
      priority                     = 144
      protocol                     = "Tcp"
      source_address_prefix        = "*"
      source_port_range            = "*"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.115", "xxx.xxx.xxx.116"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "Imprivata"
      priority                     = 145
      protocol                     = "Tcp"
      source_address_prefix        = "*"
      source_port_range            = "*"
    },

    #Adding Manual Blocks for AVD NSG Outbound Rules - START
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.46", "xxx.xxx.xxx.57"]
      destination_port_ranges      = ["5012", "515", "9100"]
      direction                    = "Outbound"
      name                         = "SafeQ-Printer-Rules"
      priority                     = 155
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000147705"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.106.81", "xxx.xxx.xxx.115", "xxx.xxx.xxx.116"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "MyADCB-Imprivata"
      priority                     = 160
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000147705"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "CRQ000000146541"
      priority                     = 170
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000146541"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15"]
      destination_port_ranges      = ["3478", "3479", "3480", "3481"]
      direction                    = "Outbound"
      name                         = "CRQ000000146541-1"
      priority                     = 175
      protocol                     = "Udp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000146541"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15", "xxx.xxx..119.141/32", "xxx.xxx..160.207/32"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "CRQ000000146541-3"
      priority                     = 185
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000146541"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx..64.0/18", "xxx.xxx..0.0/14", "xxx.xxx..0.0/15", "xxx.xxx..119.141/32", "xxx.xxx..160.207/32"]
      destination_port_range       = "80"
      direction                    = "Outbound"
      name                         = "CRQ000000146541-4"
      priority                     = 195
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000146541"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.205"]
      destination_port_range       = "445"
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-ADCNS10"
      priority                     = 215
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000146541-9"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.53", "xxx.xxx.xxx.54", "xxx.xxx.111.212"]
      destination_port_ranges      = ["80", "443"]
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-ADCBProxy"
      priority                     = 225
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000151693"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.xxx.60"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-ADCBProxy-1"
      priority                     = 235
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000151693"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.0.0/16", "xxx.xxx.0.0/16"]
      destination_port_range       = "443"
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-OnPremise-applications"
      priority                     = 245
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000151479"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.112.111", "xxx.xxx.112.112", "xxx.xxx.112.113", "xxx.xxx.112.123", "xxx.xxx.112.116"]
      destination_port_ranges      = ["8080", "9080", "9443"]
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-LendPerfect-App"
      priority                     = 255
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000151479"
    },
     {
      access                       = "Allow"
      destination_address_prefixes = ["xxx.xxx.110.178", "xxx.xxx.110.240", "xxx.xxx.110.241", "xxx.xxx.110.246", "xxx.xxx.110.242"]
      destination_port_ranges      = ["99", "88"]
      direction                    = "Outbound"
      name                         = "Avdsubnet-to-appzone-App"
      priority                     = 265
      protocol                     = "Tcp"
      source_address_prefixes      = ["xxx.xxx8.0/22"]
      source_port_range            = "*"
      description                  = "CRQ000000151479"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "Internet"
      destination_port_range     = "443"
      direction                  = "Outbound"
      name                       = "Avdsubnet-to-internet-over-443"
      priority                   = 275
      protocol                   = "*"
      source_address_prefixes    = ["xxx.xxx8.0/22"]
      source_port_range          = "*"
      description                = "CRQ000000151868"
    },
     {
      access                     = "Allow"
      destination_address_prefix = "Internet"
      destination_port_range     = "80"
      direction                  = "Outbound"
      name                       = "Avdsubnet-to-internet-over-80"
      priority                   = 285
      protocol                   = "Tcp"
      source_address_prefixes    = ["xxx.xxx8.0/22"]
      source_port_range          = "*"
      description                = "CRQ000000151868"
    }

  ]
}


module "example_nsg2"{
  source = "../../modules/network"


  security_rules = []
  subnets        = []
}