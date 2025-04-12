output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.name
}

output "kube_config" {
  description = "Kubernetes configuration"
  value       = azurerm_kubernetes_cluster.main.kube_config
  sensitive   = true
}