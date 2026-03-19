resource "aws_instance" "server" {

  count = 2

  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  subnet_id = var.subnet_id

  tags = {

    Name = "jd-server-${count.index}"

  }

}