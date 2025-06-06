# Define input variables that will be used throughout the configuration.
# These allow for dynamic values to be passed into the Terraform plan.
variable "subnet_cidr_block" {} # The CIDR block for the subnet, defining its IP address range.
variable "vpc_cidr_block" {} # The CIDR block for the VPC, defining its IP address range.
variable "avail_zone" {}
variable "env_prefix" {}
variable "anywhere" {} # Used for restricting SSH access to a specific IP.
variable "instance_type" {}
variable "image_name" {} # The name of the AMI to use for the EC2 instance.
variable "public_key_location" {}

