variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, or prod)"
  type        = string
}

variable "group_number" {
  description = "Group number from Brightspace"
  type        = string
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