
# Output the IAM Role ARN for the EKS Worker Nodes
output "eks_worker_role_arn" {
  description = "The ARN of the IAM role for EKS Worker Nodes"
  value       = aws_iam_role.eks_worker.arn
}

# Output the IAM Instance Profile Name for EKS Worker Nodes
output "eks_worker_instance_profile_name" {
  description = "The name of the IAM instance profile for EKS Worker Nodes"
  value       = aws_iam_instance_profile.eks_worker.name
}

# Output the Launch Template ID for EKS Worker Nodes
output "eks_worker_launch_template_id" {
  description = "The ID of the launch template for EKS Worker Nodes"
  value       = aws_launch_template.eks_worker.id
}

# Output the Auto Scaling Group Name for EKS Worker Nodes
output "eks_worker_asg_name" {
  description = "The name of the Auto Scaling Group for EKS Worker Nodes"
  value       = aws_autoscaling_group.eks_worker_group.name
}



