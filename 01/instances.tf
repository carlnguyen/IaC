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
resource "aws_instance" "TEST" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.security_group_01.id}"]
  subnet_id              = "${aws_subnet.test.id}"
  key_name               = "${var.key_pair}"


  tags = {
    Name = "HelloWorld"
  }
}
