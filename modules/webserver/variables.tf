variable "anywhere" {} 
variable "env_prefix" {}
variable "avail_zone" {}
variable "vpc_id" {}
variable "public_key_location" {} # Your SSH public key for secure access to EC2.
variable "instance_type" {} # Specifies the EC2 instance type (e.g., t2.micro).
variable "image_name" {}
variable "subnet_id" {} # The ID of the subnet where the EC2 instance will be launched.
  
