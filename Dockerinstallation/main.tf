provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = "ZpEbXPFFwez2ODBbexJ/wc3Xa2jvHj4xttBLPxRK"
}


resource "aws_instance" "web1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "king"
  vpc_security_group_ids = ["${aws_security_group.web4.id}"]
  tags = {
    Name = "TerraformInstance"
  }

}

resource "null_resource" "copy_execute" {

  connection {
    type        = "ssh"
    host        = aws_instance.web1.public_ip
    user        = "${var.user}"
    private_key = file("king.pem")

  }



  provisioner "file" {
    source      = "httpd.sh"
    destination = "/tmp/httpd.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/httpd.sh",
      "sh /tmp/httpd.sh",
    ]
  }

}

resource "aws_security_group" "web4" {
  name = "web4"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.cidr_blocks}"

  }
}