module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.14.3"

    name = "main"
    cidr = "10.0.0.0/16"

    azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
    private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
    public_subnets = ["10.0.64.0/19", "10.0.96.0/19"]

    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false

    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Environment = "stagging"
    }

  
}