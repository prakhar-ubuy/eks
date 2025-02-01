provider "aws" {
  region = "ap-south-1"
}

provider "kubernetes" {
  # Ensure Minikube's kubeconfig is being used
  config_path = "~/.kube/config"  # Adjust if necessary
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }

  required_version = "~> 1.0"
}
