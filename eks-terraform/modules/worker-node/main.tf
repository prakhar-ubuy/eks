# Reference the VPC module to get subnet IDs
module "vpc" {
  source = "../vpc"  # Ensure this path is correct
}

# Reference the security group module to get the worker SG ID
module "security_groups" {
  source = "../security-group"  # Ensure this path is correct
}







# EKS Worker IAM Role and Instance Profile
resource "aws_iam_role" "eks_worker" {
  name = "AmazonEKSRoleNode"

  # IAM policy allowing EC2 instances to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "eks_worker" {
  name = "eks-worker-profile"
  role = aws_iam_role.eks_worker.name
}

# Attach AmazonEKSWorkerNodePolicy to the worker role
resource "aws_iam_role_policy_attachment" "eks_worker_policy" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach AmazonEKS_CNI_Policy to the worker role
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach AmazonEC2ContainerRegistryReadOnly to allow pulling container images
resource "aws_iam_role_policy_attachment" "ecr_readonly_policy" {
  role       = aws_iam_role.eks_worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# Define the Launch Template for EKS Worker Nodes
resource "aws_launch_template" "eks_worker" {

  name_prefix = "eks-worker-template"
  image_id = var.ami_id  
  instance_type = var.instance_type
  security_group_names = [ module.security_groups.eks_worker_sg_name ]


  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "EKS Worker Node" > /etc/motd  # Example message, can be customized
  EOF
  )
 
}

# Define the Auto Scaling Group to manage EKS Worker Nodes
resource "aws_autoscaling_group" "eks_worker_group" {
   
  name = "eks-auto-scaling-group"
  desired_capacity = var.desired_capacity
  max_size = var.max_size
  min_size = var.min_size

  # Use the launch template to define the instance properties for worker nodes
  launch_template {
    id      = aws_launch_template.eks_worker.id
    version = "$Latest"  # Use the latest version of the launch template
  }

  vpc_zone_identifier = [module.vpc.subnet_id]
   

}
