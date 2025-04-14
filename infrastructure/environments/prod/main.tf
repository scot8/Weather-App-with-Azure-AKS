terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# # Configure backend
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "tfstate-rg"
#     storage_account_name = "tfstateprod"
#     container_name       = "tfstate"
#     key                  = "prod.terraform.tfstate"
#   }
# }

# Create backend storage
module "backend" {
  source = "../../modules/tf-backend"

  location             = var.location
  storage_account_name = "tf12stateprodrohan"
  tags = {
    Environment = "prod"
  }
}

# Create network
module "network" {
  source = "../../modules/network"

  environment  = "prod"
  location     = var.location
  group_number = var.group_number
  prefix       = var.prefix
}

# Create AKS cluster
module "aks" {
  source = "../../modules/aks"

  environment         = "prod"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  subnet_id           = module.network.prod_subnet_id
  node_count          = 3
}

data "azurerm_kubernetes_cluster" "credentials" {
  name                = module.aks.cluster_name
  resource_group_name = module.network.resource_group_name
  depends_on          = [module.aks]
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
}

# Create the prod namespace
resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }
  depends_on = [module.aks]
}

# Create application resources
module "app" {
  source = "../../modules/tf-app"

  environment         = "prod"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  aks_cluster         = module.aks.cluster_name
  redis_subnet_id     = module.network.prod_subnet_id
  acr_name            = "${var.prefix}g${var.group_number}acr"
  weather_api_key     = var.weather_api_key
  aks_principal_id    = module.aks.principal_id

  depends_on = [kubernetes_namespace.prod]
}