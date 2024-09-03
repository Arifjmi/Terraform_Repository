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
	project = "project-1"
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
output "aws_subnet_id" {
	value = aws_subnet.my-subnet[1].id
}

