resource "aws_security_group" "nginx-sg" {
	name        = "nginx-sg"
	description = "This is nginx security group web traffic"
	vpc_id      = aws_vpc.my-vpc.id

	tags = {
	  Name = "nginx-sg"
	}

	// Inbound rule for HTTP


		ingress {
		  from_port        = 80
		  to_port          = 80
		  protocol         = "tcp"
		  cidr_blocks      = ["0.0.0.0/0"]

		}

	// Outbound rule for HTTP


	egress {
		from_port        = 0  // inable for all ports
		to_port          = 0
		protocol         = "-1" //Applicable for all protocol
		cidr_blocks      = ["0.0.0.0/0"]   // inable for all ip

	  }

  }

