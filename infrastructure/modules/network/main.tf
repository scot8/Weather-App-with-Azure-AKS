# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = "cst8918-final-project-group-${var.group_number}"
  location = var.location
  tags     = var.tags
}

# Create Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  address_space       = ["10.0.0.0/14"]
  tags                = var.tags
}

# Create Subnets
resource "azurerm_subnet" "prod" {
  name                 = "${var.prefix}-subnet-prod"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "test" {
  name                 = "${var.prefix}-subnet-test"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "dev" {
  name                 = "${var.prefix}-subnet-dev"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "admin" {
  name                 = "${var.prefix}-subnet-admin"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.3.0.0/16"]
}