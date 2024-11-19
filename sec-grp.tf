resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv4         = "0.0.0.0/0" 
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "Webserver"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule1" {
  security_group_id = aws_security_group.webserver-sg.id
  referenced_security_group_id = aws_security_group.alb-security-group.id 
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "egress_rule1" {
  security_group_id = aws_security_group.webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

