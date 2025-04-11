# Create Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}

# Create Redis Cache
resource "azurerm_redis_cache" "redis" {
  name                = "${var.prefix}-redis-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  subnet_id           = var.redis_subnet_id
  tags                = var.tags
}

# Create Kubernetes Deployment for Weather App
resource "kubernetes_deployment" "weather_app" {
  metadata {
    name = "weather-app"
    namespace = var.environment
  }

  spec {
    replicas = var.environment == "prod" ? 3 : 1

    selector {
      match_labels = {
        app = "weather-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "weather-app"
        }
      }

      spec {
        container {
          name  = "weather-app"
          image = "${azurerm_container_registry.acr.login_server}/weather-app:${var.image_tag}"

          env {
            name  = "WEATHER_API_KEY"
            value = var.weather_api_key
          }

          env {
            name  = "REDIS_URL"
            value = "rediss://:${azurerm_redis_cache.redis.primary_access_key}@${azurerm_redis_cache.redis.hostname}:${azurerm_redis_cache.redis.ssl_port}"
          }

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Create Kubernetes Service for Weather App
resource "kubernetes_service" "weather_app" {
  metadata {
    name = "weather-app"
    namespace = var.environment
  }

  spec {
    selector = {
      app = "weather-app"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
} 