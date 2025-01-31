output "eks_cluster_endpoint" {
  value = module.eks.endpoint
}

output "eks_cluster_certificate_authority" {
  value = module.eks.ca
}

output "eks_worker_role_arn" {
  value = module.worker_node.eks_worker_role_arn
}
