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
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.security_group_01.id}"]
  subnet_id              = "${aws_subnet.test.id}"
  key_name               = "${var.key_pair}"

  tags = {
    Name = "NGINX"
  }
  # provisioner "local-exec" {
  #   command = <<EOH
  #   sudo apt-get update
  #   sudo apt-get install -y ansible
  #   EOH
  # }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = "${aws_instance.Helloworld.public_ip}"
    private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    agent       = true
  }
  provisioner "file" {
    source      = "./file/ansible.sh"
    destination = "/tmp/ansible.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansible.sh",
      "sudo /tmp/ansible.sh"
    ]
  }
  # connection {
  #   host = "${aws_instance.Helloworld.public_ip}"
  #   type = "ssh"
  #   user = "ubuntu"
  #   private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  # }
}
