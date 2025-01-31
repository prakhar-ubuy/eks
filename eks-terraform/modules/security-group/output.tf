# outputs.tf

output "eks_worker_sg_id" {
  value = aws_security_group.eks_workers.id
  description = "The ID of the security group for EKS worker nodes"
}

output "eks_worker_sg_name" {
  value = aws_security_group.eks_workers.name
  description = "The name of the security group for EKS worker nodes"
}
