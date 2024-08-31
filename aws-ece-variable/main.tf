resource "aws_instance" "web" {
	ami           = var.ami
	instance_type = "t2.micro"
	count = var.instance_count  // Number of instance
  
	tags = {
	  Name = "Myserver"
	}
  }
