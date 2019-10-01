locals {
  key_pair      = "carlnguyen"
  instance_type = "t2.micro"
  PRIVATE_KEY_PATH = "/Users/cuongnguyen/Desktop/Study/aws-credentials/carlnguyen.pem"
}
provider "aws" {
  # version = "~> 2.0"
  region  = "ap-southeast-1"
}
data "aws_subnet" "test" {
  tags = {
    Name = "PUBLIC-SUBNET-TEST"
  }
}
data "aws_vpc" "vpc01" {
  tags = {
    Name = "VPC-TEST"
  }
}
data "aws_security_groups" "security_group_01" {}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64-minimal-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "Helloworld" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${local.instance_type}"
  # vpc_security_group_ids = ["${data.aws_security_groups.security_group_01.id}"]
  vpc_security_group_ids = ["${data.aws_vpc.vpc01.id}"]
  subnet_id              = "${data.aws_subnet.test.id}"
  key_name               = "${local.key_pair}"

  tags = {
    Name = "NGINX"
  }
  provisioner "file" {
    source      = "file"
    destination = "/tmp"

    connection {
      type        = "ssh"
      host        = "${aws_instance.Helloworld.public_ip}"
      user        = "ubuntu"
      private_key = "${file(local.PRIVATE_KEY_PATH)}"
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/file/*",
      "sudo /tmp/file/installation_scripts/install_ansible.sh"
    ]
    connection {
      type        = "ssh"
      host        = "${aws_instance.Helloworld.public_ip}"
      user        = "ubuntu"
      private_key = "${file(local.PRIVATE_KEY_PATH)}"
    }
  }
}
