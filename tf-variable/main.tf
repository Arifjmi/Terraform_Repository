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
	region = "us-west-1"
  }

  resource "aws_instance" "web" {
	ami           = "ami-04fdea8e25817cd69"
	instance_type = var.instance_type  // use variable

	// root_block_device

	root_block_device {
		volume_size           = var.root_volume_config.v_size
		volume_type           = var.root_volume_config.v_type
		delete_on_termination = true
	  }
  
	tags = merge(var.additional_tag, {
	  Name = "Myserver"
	})
  }


 

