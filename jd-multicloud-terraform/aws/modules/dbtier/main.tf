resource "aws_subnet" "db_subnet" {

  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"

}