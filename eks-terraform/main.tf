

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
}

# Security Group Module
module "security_groups" {
  source = "./modules/security-group"
}

# EKS Module
module "eks" {
  source       = "./modules/eks"
  cluster_name = "Eks-cluster"
}

# Worker Node Module
module "worker_node" {
  source = "./modules/worker-node"
}

# Helm Module for NGINX Ingress
module "helm" {
  source = "./modules/helm"
}
