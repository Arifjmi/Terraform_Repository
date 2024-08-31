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
	region = "us-east-1"
  }

resource "aws_instance" "web" {
	ami           = "ami-066784287e358dad1"
	instance_type = "t2.micro"
	
	key_name = "key"   // Existing Key pair that means created in aws consol
  
	tags = {
	  Name = "Hello_server"
	}
  }
