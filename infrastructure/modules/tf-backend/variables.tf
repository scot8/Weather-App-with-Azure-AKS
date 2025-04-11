variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for Terraform state"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 