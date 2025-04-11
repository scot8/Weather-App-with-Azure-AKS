

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, or prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cst8918"
}

variable "acr_name" {
  description = "Name for Azure Container Registry"
  type        = string
}

variable "weather_api_key" {
  description = "OpenWeather API Key"
  type        = string
  sensitive   = true
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}

variable "redis_subnet_id" {
  description = "Subnet ID for Redis Cache"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 