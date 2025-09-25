#########################################################
# Application Load Balancer (public-facing, multi-AZ)
#########################################################

resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  # Public subnets across multiple AZs
  subnets = [for s in aws_subnet.management : s.id]
  tags = {
    Name = "app-alb"
  }
}

#########################################################
# Target Group
#########################################################

resource "aws_lb_target_group" "app_tg" {
  name        = "app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = "/" # hits /index.html
    protocol            = "HTTP"
    matcher             = "200" # Expect HTTP 200 OK
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "app-tg"
  }
}

#########################################################
# ALB Listener
#########################################################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}