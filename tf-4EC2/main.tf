terraform {
	required_providers {
	  aws = {
		source  = "hashicorp/aws"
		version = "~> 5.0"
	  }
	}
  }
  
  # Configure the AWS Provider
  provider "aws" {
	region = var.region
  }

locals {
	project = "project-01"
}

  resource "aws_vpc" "my-vpc" {
	cidr_block = "10.0.0.0/16"
  
  tags = {
	Name = "${local.project}-vpc"
  }
}

  resource "aws_subnet" "my-subnet" {
	vpc_id     = aws_vpc.my-vpc.id
	cidr_block = "10.0.${count.index}.0/24"  // for different value (10.0.0.0/24,10.0.1.0/24)
	count = 2        // Number of subnets(How many subnet you want to create)
  
	tags = {
	  Name = "${local.project}-subnet-${count.index}"  //For creating subnet name should be different)
	}
  }

// Creating 4 ec2 instance
resource "aws_instance" "main" {
	ami = "ami-066784287e358dad1"
	instance_type = "t2.micro"
	count = 4
	subnet_id = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet))  //Here we create 2EC2 in 1subnet 
// 0%2=0
// 1%2=1
// 2%2=0
// 3%2=1


	tags = {
		Name = "${local.project}-aws_instance-${count.index}"
	}
}
output "aws_subnet_id" {
	value = aws_subnet.my-subnet[1].id
}

