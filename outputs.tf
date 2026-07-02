# Ouput parameters for the Hub and Spoke Terraform module
output "hub_vnet_id" {
  description = "The ID of the Hub Virtual Network"
  value       = azurerm_virtual_network.hub_vnet.id
}

output "spoke1_vnet_id" {
  description = "The ID of the Spoke 1 Virtual Network"
  value       = azurerm_virtual_network.spoke1_vnet.id
}

output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.network_rg.name
}

output "spoke1_subnet_id" {
  description = "The ID of the Spoke 1 Workload Subnet"
  value       = azurerm_subnet.spoke1_subnet.id
}