provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAWVHBCL6MUUPL7R7P"
    secret_key = "ZpEbXPFFwez2ODBbexJ/wc3Xa2jvHj4xttBLPxRK"
}
resource ""aws_instance" "instantce" {
    ami = ""
  
}

resource "aws_elb" "example" {
  name = "ElasticloadBalancer"
    availability_zones = ["ap-south-1a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}