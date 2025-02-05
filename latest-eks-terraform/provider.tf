# Configure the AWS Provider
provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  
  }
}



data "aws_eks_cluster" "cluster" {
  name = var.cluster_name

  depends_on = [ module.eks ]
}
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name

  depends_on = [ module.eks ]
}
data "aws_iam_openid_connect_provider" "oidc_provider" {
  url = "https://oidc.eks.ap-south-1.amazonaws.com/id/BF5B1231A5C1E9952118DF644B15D39A"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}