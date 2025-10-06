terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
 backend "s3" {
    bucket         = "venky06102025-hello"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
  }
}
provider "aws" {
  region = var.region
}
#----------VPC--------------
    resource "aws_vpc" "main" {
      cidr_block       = var.vpc_cidr
      instance_tenancy = "default"
      enable_dns_support = true
      enable_dns_hostnames = true

      tags = {
        Name = "${var.env_name}-vpc"
      }
    }
    #-----------Subnet------------
        resource "aws_subnet" "public_subnet" {
      vpc_id            = aws_vpc.main.id
      cidr_block        = var.subnet_cidr
      availability_zone = "${var.region}a"
      map_public_ip_on_launch = true
      tags = {
        Name = "${var.env_name}-subent"
      }
    }
     # ----------- Internet Gateway (IGW)--------------
        resource "aws_internet_gateway" "main" {
      vpc_id = aws_vpc.main.id

      tags = {
        Name =  "{var.env_name}-igw"
      }
    }
    
    #----------- EC2 instances ------------
    resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.env_name}-instance"
  }
}
