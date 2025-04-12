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
}

variable "subnet_id" {
  description = "Subnet ID for AKS nodes"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cst8918"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}