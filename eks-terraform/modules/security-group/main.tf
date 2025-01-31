# security_groups/main.tf
module "vpc" {
  source = "../vpc"
}

resource "aws_security_group" "eks_workers" {
  vpc_id = module.vpc.vpc_id  # Reference to VPC ID
  name = "eks-security-group"

  # Inbound rules
  ingress {
    from_port   = 22  # Allow SSH on port 22 (for management, optional)
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP (change this for more restrictive access)
  }

  ingress {
    from_port   = 80  # Allow HTTP on port 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP
  }

  ingress {
    from_port   = 443  # Allow HTTPS on port 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP
  }

  # Allow communication between worker nodes (for inter-node communication)
  ingress {
    from_port   = 10250  # Kubelet port
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any node in the VPC or adjust accordingly
  }

  ingress {
    from_port   = 443  # Allow traffic on port 443 for Kubernetes API
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from any IP (or restrict based on CIDR if necessary)
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic to communicate with EKS control plane and internet
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  # Outbound traffic for communication with EKS control plane (port 443)
  egress {
    from_port   = 443  # Allow HTTPS to EKS API server
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow to any destination (EKS control plane)
  }

  # Optional: Allow traffic for custom applications (e.g., port 8080 for your apps)
  egress {
    from_port   = 8080  # Example custom port for your apps
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed for your use case
  }
}
