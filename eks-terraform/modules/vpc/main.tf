resource "aws_default_vpc" "default" {
  tags = {
    Name = "default_vpc"
  }
}



resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Default subnet for ap-south-1a"
  }
}