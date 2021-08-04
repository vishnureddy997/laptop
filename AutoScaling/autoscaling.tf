provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWVHBCL6MUUPL7R7P"
  secret_key = "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"

}
resource "aws_instance" "war"  {
    ami = "ami-04db49c0fb2215364"
    key_name = "king"
    instance_type = "t2.micro"
    tags = {
        Name = "autoscaling"
    }
}

resource "aws_security_group" "webs" {
  name = "webs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_launch_template" "football" {
  name_prefix   = "vishnu"
  image_id      = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["ap-south-1a"]
  desired_capacity   = 3
  max_size           = 4
  min_size           = 3

  launch_template {
    id      = aws_launch_template.football.id
    version = "$Latest"
  }
}

