output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "prod_subnet_id" {
  description = "ID of the production subnet"
  value       = azurerm_subnet.prod.id
}

output "test_subnet_id" {
  description = "ID of the test subnet"
  value       = azurerm_subnet.test.id
}

output "dev_subnet_id" {
  description = "ID of the development subnet"
  value       = azurerm_subnet.dev.id
}

output "admin_subnet_id" {
  description = "ID of the admin subnet"
  value       = azurerm_subnet.admin.id
}