provider "aws" {
  region = "us-east-2"
}

############### VPC ##########################

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

############## IGW    ######################

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
  }
}

############## subnet ###############

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "mysubnet"
  }
}

################ route table ###############

resource "aws_route_table" "myrtb" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myrtb"
  }
}

################# route ###################

resource "aws_route" "myroute" {
  route_table_id         = aws_route_table.myrtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
  depends_on             = [aws_route_table.myrtb]
}

################# security group ########################

resource "aws_security_group" "mysg" {
  name        = "allow all traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "Allow all traffic"
    from_port        = 0    # all ports
    to_port          = 0    # all ports
    protocol         = "-1" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "mysg"
  }
}

############### route table association ###############

resource "aws_route_table_association" "myassociation" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myrtb.id
}
#######################EC2-INSTANCE ##############

resource "aws_instance" "S1" {
  ami           = "ami-0cd3c7f72edd5b06d"
  instance_type = "t2.micro"

  tags = {
    Name = "Server1"
  }
}


provider "aws" {
  region = "us-east-2"
}

##Data fetching Terraform using filter

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["mysubnet"] # insert values here
  }
}

resource "aws_instance" "S2" {
  ami           = "ami-0cd3c7f72edd5b06d"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id

  tags = {
    Name = "Server2"
  }
}
