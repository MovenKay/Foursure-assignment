variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2" # Change this to your desired AWS region
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16" # Replace with your preferred CIDR block
}

variable "subnet_cidr_block" {
  description = "CIDR block for subnet"
  default     = "10.0.0.0/24" # Replace with your preferred CIDR block within the VPC range
}

variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0507f77897697c4ba" # Replace this with your preferred AMI ID
}

variable "ec2_instance_type" {
  description = "Instance type for EC2 instance"
  default     = "t2.micro" # Replace with your desired instance type
}

variable "rds_instance_type" {
  description = "Instance type for RDS instance"
  default     = "db.t3.micro" # Replace with your desired RDS instance type
}

variable "rds_allocated_storage" {
  description = "Allocated storage for RDS instance (in GB)"
  default     = 20 # Replace with your desired storage capacity
}

variable "rds_username" {
  description = "Username for RDS instance"
  default     = "moven" # Replace this with your desired username
}

variable "rds_password" {
  description = "Password for RDS instance"
  default     = "moven@123" # Replace this with your desired password
}

variable "ec2_key" {
  description = "Key pair"
  default     = "foursure-key" 
}
