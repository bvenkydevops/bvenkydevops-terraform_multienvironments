variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}
variable "env_name" {
  description = "Environment name (dev, qa, prod)"
  type = string
}
variable "vpc_cidr" {
  description = "CIDR block for subnet"
  type = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
}
variable "ami_id" {
  description = "AMI ID to use for EC2"
  type = string
}
variable "subnet_cidr" {
  description = "aws"
  type = string
}
