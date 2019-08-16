provider "aws" {
  version = "~> 2.0"
  region  = "${var.region}"
}
resource "aws_vpc" "vpc01" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "vpc-test"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc01.id}"

  tags = {
    Name = "test_gateway"
  }
}
resource "aws_subnet" "test" {
  vpc_id                  = "${aws_vpc.vpc01.id}"
  cidr_block              = "${var.public_subnet}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_test"
  }
}
resource "aws_route_table" "route_table_vpc01" {
  vpc_id = "${aws_vpc.vpc01.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id = "0.0.0.0/0"
  route_table_id = "${aws_route_table.route_table_vpc01.id}"
}

resource "aws_security_group" "security_group_01" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = "${aws_vpc.vpc01.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}
