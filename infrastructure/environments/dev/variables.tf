variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "canadacentral"
}

variable "group_number" {
  description = "Your group number from Brightspace"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cst8918"
}

variable "weather_api_key" {
  description = "OpenWeather API Key"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name (dev, test, or prod)"
  type        = string
  default     = "dev"
}