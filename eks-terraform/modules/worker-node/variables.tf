

variable "ami_id" {
  description = "The AMI ID for the EKS worker node instances"
  type        = string
  default     = "ami-00bb6a80f01f03502"  # Default to an ubuntu AMI, you can update this as necessary
}

variable "instance_type" {
  description = "The instance type for the EKS worker nodes"
  type        = string
  default     = "t2.micro   "  # You can modify this default if needed
}

variable "desired_capacity" {
  description = "Desired capacity (number of instances) for the EKS worker group"
  type        = number
  default     = 2  # Default value, can be modified
}

variable "max_size" {
  description = "Maximum size of the EKS worker group"
  type        = number
  default     = 3  # Default value, can be modified
}

variable "min_size" {
  description = "Minimum size of the EKS worker group"
  type        = number
  default     = 1  # Default value, can be modified
}
