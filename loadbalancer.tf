resource "aws_lb" "my-application-lb" {
  name               = "my-application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-security-group.id]
  subnets            = [aws_subnet.aws_private1.id , aws_subnet.aws_private2.id]
  ip_address_type    = "ipv4"
  
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "application-lb-tg" {
  name     = "application-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  
  health_check {
    protocol = "HTTP"
    path = "/"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 6
    interval = 10
    
    }
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.application-lb-tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}


resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.my-application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application-lb-tg.arn
      }
}