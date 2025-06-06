terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "eu-north-1"
  
}

# --- VPC (Virtual Private Cloud) Configuration ---
# This section defines your isolated network in AWS.
resource "aws_vpc" "myapp-vpc" {
# The CIDR block for the entire VPC, defining its IP address range.
  cidr_block = var.vpc_cidr_block
  tags = {
    # Naming the VPC based on the environment prefix for easy identification.
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  #This module creates a subnet within the VPC.
  source = "./modules/subnet"
  # Passes the CIDR block for the subnet.
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-server" {
  # This module creates an EC2 instance within the subnet.
  source = "./modules/webserver"
  # Passes various parameters to the module.
  anywhere = var.anywhere
  env_prefix = var.env_prefix
  avail_zone = var.avail_zone
  vpc_id = aws_vpc.myapp-vpc.id
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  image_name = var.image_name
  subnet_id = module.myapp-subnet.subnet
}