# bvenkydevops-terraform_multienvironments
```
📁 Folder Structure
terraform/
 ├── main.tf
 ├── variables.tf
 ├── outputs.tf
 ├── dev.tfvars
 ├── qa.tfvars
 └── prod.tfvars
```
----------------------------------------------------------------
```
🧱 main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

# --- VPC ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env_name}-vpc"
  }
}

# --- Subnet ---
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_name}-subnet"
  }
}

# --- EC2 Instance ---
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.env_name}-instance"
  }
}

⚙️ variables.tf
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "env_name" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for EC2"
  type        = string
}

📤 outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

```
---------------------------------------------------------------------
```
🌱 Environment Variable Files
🟢 dev.tfvars
env_name       = "dev"
vpc_cidr       = "10.0.0.0/16"
subnet_cidr    = "10.0.1.0/24"
instance_type  = "t3.micro"
ami_id         = "ami-0dee22c13ea7a9a67"
```
---------------------------------------------------------------------------
```
🟡 qa.tfvars
env_name       = "qa"
vpc_cidr       = "10.1.0.0/16"
subnet_cidr    = "10.1.1.0/24"
instance_type  = "t3.small"
ami_id         = "ami-0dee22c13ea7a9a67"
```
------------------------------------------------------------------------
```
🔴 prod.tfvars
env_name       = "prod"
vpc_cidr       = "10.2.0.0/16"
subnet_cidr    = "10.2.1.0/24"
instance_type  = "t3.medium"
ami_id         = "ami-0dee22c13ea7a9a67"
```
--------------------------------------------------------------------------------
```
🚀 Commands to Run
1️⃣ Initialize Terraform
terraform init

2️⃣ Create Workspaces
terraform workspace new dev
terraform workspace new qa
terraform workspace new prod

```
-----------------------------------------------------------------------
```
3️⃣ Apply for Specific Environment
terraform workspace select dev
terraform apply -var-file="dev.tfvars"
```
----------------------------------------------------------------------
```
For QA:

terraform workspace select qa
terraform apply -var-file="qa.tfvars"
```
---------------------------------------------------------------------------
```
For PROD:

terraform workspace select prod
terraform apply -var-file="prod.tfvars"
```
----------------------------------------------------------------------------
```
✅ Result

Single codebase.

Three different environments.

Isolated state files (if backend key includes ${terraform.workspace}).
```
---------------------------------------------------------------------------------------


<img width="1920" height="1080" alt="Screenshot (18)" src="https://github.com/user-attachments/assets/18c7bd20-1825-4caa-9ffb-703aa3f6d193" />
<img width="1920" height="1080" alt="Screenshot (19)" src="https://github.com/user-attachments/assets/4cdc80cd-6730-495e-be64-6de1306e0ea8" />

<img width="1920" height="1080" alt="Screenshot (20)" src="https://github.com/user-attachments/assets/32e78b20-7854-45e3-a4b9-0f21026aadd6" />

<img width="1920" height="1080" alt="Screenshot (21)" src="https://github.com/user-attachments/assets/30d3ab92-946c-44d0-a9ba-3cc367d8f914" />
<img width="1920" height="1080" alt="Screenshot (22)" src="https://github.com/user-attachments/assets/73f30c2d-478f-4b5b-985c-7a749044aa8f" />

<img width="1920" height="1080" alt="Screenshot (23)" src="https://github.com/user-attachments/assets/dc71a6d7-3e62-4a5a-b657-8e6f7dd469fa" />
<img width="1920" height="1080" alt="Screenshot (24)" src="https://github.com/user-attachments/assets/2b8c0da9-925c-45da-93fd-5f3c02e59b68" />

<img width="1920" height="1080" alt="Screenshot (25)" src="https://github.com/user-attachments/assets/bcb2f973-f4b1-4855-8f20-a59dae77eb12" />
<img width="1920" height="1080" alt="Screenshot (26)" src="https://github.com/user-attachments/assets/d6adadb5-57b3-41e9-97d2-03c1f63d81e7" />
<img width="1920" height="1080" alt="Screenshot (27)" src="https://github.com/user-attachments/assets/8cdbae95-e0b7-4cd5-bba4-ec14a32a75ac" />
<img width="1920" height="1080" alt="Screenshot (28)" src="https://github.com/user-attachments/assets/e8dd7c0a-928b-4c33-8a4c-fff47e503885" />
<img width="1920" height="1080" alt="Screenshot (29)" src="https://github.com/user-attachments/assets/1c9384c8-c292-4d71-bbb4-11a05ee375a3" />
<img width="1920" height="1080" alt="Screenshot (30)" src="https://github.com/user-attachments/assets/62470aec-dc3a-45e6-8b71-0f51ae924c95" />

<img width="1920" height="1080" alt="Screenshot (31)" src="https://github.com/user-attachments/assets/62a4b777-dcb2-4a5d-849b-14154e4eceed" />

<img width="1920" height="1080" alt="Screenshot (32)" src="https://github.com/user-attachments/assets/89f6b734-c697-4311-bc57-466241ec180d" />
<img width="1920" height="1080" alt="Screenshot (33)" src="https://github.com/user-attachments/assets/ff1d7325-19bf-42fe-8bff-5c000d70fd73" />
<img width="1920" height="1080" alt="Screenshot (34)" src="https://github.com/user-attachments/assets/91caafe7-16e5-4e7a-8041-056445376819" />









