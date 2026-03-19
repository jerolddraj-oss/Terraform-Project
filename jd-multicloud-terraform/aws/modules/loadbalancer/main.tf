resource "aws_lb" "web_lb" {

  name               = "jd-web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets

}