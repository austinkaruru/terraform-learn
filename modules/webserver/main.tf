# --- Default Security Group Configuration ---
# This section configures the default security group for your VPC.
# Security groups act as virtual firewalls to control inbound and outbound traffic
# for your instances.
resource "aws_default_security_group" "default-sg" {
  # Associates the security group with your VPC.
  vpc_id = var.vpc_id

  # Inbound rule: Allows SSH access (port 22) from your specified IP address.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.anywhere]
  }

  # Inbound rule: Allows HTTP access (port 8080) from anywhere (0.0.0.0/0).
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.anywhere]
  }

  # Outbound rule: Allows all outbound traffic from instances associated with this security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = [var.anywhere]
    prefix_list_ids = []
  }

  tags = {
    # Naming the default security group.
    Name = "${var.env_prefix}-default-sg"
  }
}

# --- Data Source: Latest Amazon Linux AMI ---
# This section retrieves information about the latest Amazon Linux 2 AMI.
# Data sources allow you to fetch information from AWS.
data "aws_ami" "latest-amazon-linux-image" {
  # Ensures the most recent AMI is selected.
  most_recent = true
  # Specifies that the AMI must be owned by Amazon.
  owners = ["amazon"]
  filter {
    name   = "name"
    # Filters for AMIs with names matching this pattern (Amazon Linux 2).
    # values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    # Filters for AMIs using hardware virtual machine (HVM).
    values = ["hvm"]
  }
}

# --- Output Variables ---
# These sections define output values that will be displayed after Terraform applies the configuration.
# They are useful for easily retrieving important information about your deployed resources.

# --- SSH Key Pair Configuration ---
# This section creates an SSH key pair in AWS, which is used for secure shell access to your EC2 instance.
resource "aws_key_pair" "ssh-key" {
  # The name for the key pair.
  key_name   = "server-key"
  # Your SSH public key content.
  public_key = file(var.public_key_location)
}

# --- EC2 Instance Configuration ---
# This section defines your Amazon EC2 instance (virtual server).
resource "aws_instance" "myapp-server" {
  # The Amazon Machine Image (AMI) to use for the instance.
  ami = data.aws_ami.latest-amazon-linux-image.id
  # The type of instance to launch (e.g., t2.micro).
  instance_type = var.instance_type
  # The subnet where the instance will be launched.
  subnet_id = var.subnet_id.id
  # Associates the default security group with this instance.
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  # The Availability Zone where the instance will be launched.
  availability_zone = var.avail_zone

  # Assigns a public IP address to the instance, making it accessible from the internet.
  associate_public_ip_address = true
  # The name of the SSH key pair to use for connecting to the instance.
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  tags = {
    # Naming the EC2 instance.
    Name = "${var.env_prefix}-server"
  }
}
