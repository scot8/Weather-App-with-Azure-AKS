output "acr_login_server" {
  description = "The login server URL for the container registry"
  value       = azurerm_container_registry.acr.login_server
}

output "redis_connection_string" {
  description = "Redis connection string"
  value       = "rediss://:${azurerm_redis_cache.redis.primary_access_key}@${azurerm_redis_cache.redis.hostname}:${azurerm_redis_cache.redis.ssl_port}"
  sensitive   = true
}

output "app_url" {
  description = "URL of the deployed application"
  value       = kubernetes_service.weather_app.status[0].load_balancer[0].ingress[0].ip
} 