resource "aws_subnet" "app_subnet" {

  vpc_id     = var.vpc_id
  cidr_block = "10.0.2.0/24"

}