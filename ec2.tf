resource "aws_instance" "webserver1" {
  ami = "ami-0166fe664262f664c"
  instance_type = "t2.micro"
  key_name = "webserver"
  user_data = file("userdata.sh")
  associate_public_ip_address = true
  subnet_id = aws_subnet.aws_public1.id
  security_groups = [aws_security_group.webserver-sg.id]

}

