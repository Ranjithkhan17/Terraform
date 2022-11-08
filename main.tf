provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAUTOTMJ24HR5OYLHY"
  secret_key = "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"
}
#Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "first_vpc"
  }
}

# Create a internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_gate"
  }
}

# create a internet gateway

resource "aws_route_table" "my_route" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "internet_gate"
  }
}


#create a subnet

resource "aws_subnet" "my_sub" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "sub1"
  }
}


# Associating route table with subnet

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_sub.id
  route_table_id = aws_route_table.my_route.id
}

# Create a security group

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH"
    from_port   = 2
    to_port     = 2
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_WEB"
  }
}


# CREATE OUR NETWORK INTERACE  --BY RANJITH

resource "aws_network_interface" "my_vnet" {
  subnet_id       = aws_subnet.my_sub.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]


}


# ASSIGN AN ELASTIC IP ADDRESS TO OUR NETWORK INTERFACE

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.my_vnet.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.gw]
}


# CREATE AWS UBUNTU INSTANCE --RANJITH

resource "aws_instance" "my_web_server" {
  ami               = "ami-062df10d14676e201"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name          = "project1"



  network_interface {
    device_index        = 0
    network_interface_id = aws_network_interface.my_vnet.id
  }

  user_data = <<-EOF

    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo bash -c 'echo your very first web server > /var/www/html/index.html'
    EOF


}