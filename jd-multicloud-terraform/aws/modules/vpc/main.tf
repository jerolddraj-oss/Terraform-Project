resource "aws_vpc" "jd_vpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "jd-vpc"
  }

}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.jd_vpc.id

}