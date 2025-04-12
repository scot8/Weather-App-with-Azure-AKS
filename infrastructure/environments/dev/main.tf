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

# Configure backend
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatedev"
    container_name      = "tfstate"
    key                 = "dev.terraform.tfstate"
  }
}

# Create backend storage
module "backend" {
  source = "../../modules/tf-backend"
  
  location            = var.location
  storage_account_name = "tfstatedev"
  tags = {
    Environment = "dev"
  }
}

# Create network
module "network" {
  source = "../../modules/network"
  
  environment = "dev"
  location    = var.location
  group_number = var.group_number
  prefix      = var.prefix
}

# Create AKS cluster
module "aks" {
  source = "../../modules/aks"
  
  environment     = "dev"
  location        = var.location
  resource_group  = module.network.resource_group_name
  subnet_id       = module.network.dev_subnet_id
  node_count      = 1
}

# Create application resources
module "app" {
  source = "../../modules/tf-app"
  
  environment     = "dev"
  location        = var.location
  resource_group  = module.network.resource_group_name
  aks_cluster     = module.aks.cluster_name
  redis_subnet_id = module.network.dev_subnet_id
  acr_name        = "${var.prefix}acrdev"
  weather_api_key = var.weather_api_key
}