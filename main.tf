# Dedicated Resource Group for Networking hub
resource "azurerm_resource_group" "network_rg" {
    name     = "rg-hub-spoke-prod"
    location = "East US"
}

# The Hub Virtual Network 
resource "azurerm_virtual_network" "hub_vnet" {
    name                = "vnet-hub-prod"
    location            = azurerm_resource_group.network_rg.location
    resource_group_name = azurerm_resource_group.network_rg.name
    address_space       = ["10.1.0.0/16"]
}

# Gateway Subnet for the Hub Virtual Network
resource "azurerm_subnet" "gateway_subnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.network_rg.name
    virtual_network_name = azurerm_virtual_network.hub_vnet.name
    address_prefixes     = ["10.1.1.0/24"]
}
