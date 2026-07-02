# Dedicated Resource Group for Networking hub
resource "azurerm_resource_group" "network_rg" {
    name     = "rg-hub-spoke-${var.environment}"
    location = var.location
}

# The Hub Virtual Network 
resource "azurerm_virtual_network" "hub_vnet" {
    name                = "vnet-hub-${var.environment}"
    location            = azurerm_resource_group.network_rg.location
    resource_group_name = azurerm_resource_group.network_rg.name
    address_space       = var.hub_address_space

    tags = {
        environment = var.environment
        project     = var.project_name
    }
}

# Gateway Subnet for the Hub Virtual Network
resource "azurerm_subnet" "gateway_subnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.network_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = ["10.1.1.0/24"]
}

# Spoke 1 Virtual Network 
resource "azurerm_virtual_network" "spoke1_vnet" {
    name                = "vnet-spoke1-${var.environment}"
    location            = azurerm_resource_group.network_rg.location
    resource_group_name = azurerm_resource_group.network_rg.name
    address_space       = var.spoke1_address_space

    tags = {
        environment = var.environment
        project     = var.project_name
    }
}   

# Spoke 1 Workload Subnet 
resource "azurerm_subnet" "spoke1_subnet" {
    name                 = "snet-spoke1-workload"
    resource_group_name  = azurerm_resource_group.network_rg.name
    virtual_network_name = azurerm_virtual_network.spoke1_vnet.name
    address_prefixes     = ["10.2.1.0/24"]
}

# Peering: Hub -> Spoke1
resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
    name                      = "peer-hub-to-spoke1"
    resource_group_name       = azurerm_resource_group.network_rg.name
    virtual_network_name      = azurerm_virtual_network.hub_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.spoke1_vnet.id
    allow_forwarded_traffic   = true
    allow_virtual_network_access = true
}

# Peering: Spoke1 -> Hub
resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
    name                      = "peer-spoke1-to-hub"
    resource_group_name       = azurerm_resource_group.network_rg.name
    virtual_network_name      = azurerm_virtual_network.spoke1_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
    allow_forwarded_traffic   = true
    allow_virtual_network_access = true
}
