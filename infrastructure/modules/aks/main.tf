resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.prefix}-aks-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix         = "${var.prefix}-aks-${var.environment}"

  default_node_pool {
    name       = "default"
    node_count = var.environment == "test" ? 1 : var.node_count
    vm_size    = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
    //enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }
  

  network_profile {
    network_plugin = "azure"
    service_cidr       = "10.240.0.0/16"
    dns_service_ip     = "10.240.0.10"
  }

  

  tags = var.tags
  kubernetes_version = "1.31.5"

}