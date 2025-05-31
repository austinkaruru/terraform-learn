provider "aws" {
    region = "eu-north-1"

}


variable "cidr_blocks" {
    description = "cidr blocks & name tags for vpc & subnets"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable avail_zone {}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
      Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-vpc-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name = var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id

}

output "dev-vpc-subnet-id" {
    value = aws_subnet.dev-vpc-subnet.id
}