# --- Subnet Configuration ---
# This section defines a subnet within your VPC, a logical segmentation of the network.

resource "aws_subnet" "myapp-subnet-1" {
  # Associates this subnet with the VPC defined above.
  vpc_id = var.vpc_id
  # The CIDR block for this specific subnet.
  cidr_block = var.subnet_cidr_block
  # Specifies the Availability Zone where this subnet will be deployed.
  availability_zone = var.avail_zone
  tags = {
    # Naming the subnet.
    Name = "${var.env_prefix}-subnet-1"
  }
}

# --- Internet Gateway Configuration ---
# This section creates an Internet Gateway, which allows communication between your VPC
# and the internet.
resource "aws_internet_gateway" "myapp-igw" {
  # Associates the internet gateway with your VPC.
  vpc_id = var.vpc_id
  tags = {
    # Naming the internet gateway.
    Name = "${var.env_prefix}-igw"
  }
}

# --- Default Route Table Configuration ---
# This section modifies the default route table associated with your VPC.
# By default, a VPC comes with a main route table.
resource "aws_default_route_table" "default-rtb" {
  # Refers to the ID of the default route table for the VPC.
  default_route_table_id = var.default_route_table_id

  route {
    # Adds a route to the default route table, directing all outbound traffic
    # to the internet gateway. This makes resources in subnets associated with
    # this route table publicly accessible.
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    # Naming the default main route table.
    Name = "${var.env_prefix}-main-rtb"
  }
}
