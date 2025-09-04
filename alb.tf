resource "aws_lb" "alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id]
  enable_deletion_protection = false

  tags = {
    Name = "path-alb"
  }
}

# --- Target Group Resources ---
resource "aws_lb_target_group" "alb_tg_home" {
  name        = "alb-tg-home"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 5
    matcher             = "200-399" # Corrected matcher to accept 2xx and 3xx
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = {
    Name = "alb-tg-home"
  }
}

resource "aws_lb_target_group" "alb_tg_images" {
  name        = "alb-tg-images"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/images/"
    timeout             = 5
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = {
    Name = "alb-tg-images"
  }
}

resource "aws_lb_target_group" "alb_tg_register" {
  name        = "alb-tg-register" # Corrected unique name
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/register/"
    timeout             = 5
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = {
    Name = "alb-tg-register" # Corrected unique tag
  }
}

# --- ALB Listener and Rule Resources ---
resource "aws_lb_listener" "alb_http_listener" { # Renamed for clarity
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_home.arn # Corrected target_group reference
  }
}

resource "aws_lb_listener_rule" "alb_rule_images" {
  listener_arn = aws_lb_listener.alb_http_listener.arn
  priority     = 10 # Priority must be unique and higher than other specific rules
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_images.arn
  }
  condition {
    path_pattern {
      values = ["/images/*"] # Added wildcard for robustness
    }
  }
}

resource "aws_lb_listener_rule" "alb_rule_register" {
  listener_arn = aws_lb_listener.alb_http_listener.arn
  priority     = 20 # Corrected to a unique priority
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_register.arn
  }
  condition {
    path_pattern {
      values = ["/register/*"] # Added wildcard for robustness
    }
  }
}

# --- Target Group Attachments ---
resource "aws_lb_target_group_attachment" "alb_tg_attach_home" {
  target_group_arn = aws_lb_target_group.alb_tg_home.arn
  target_id        = aws_instance.web_server_1.id
}

resource "aws_lb_target_group_attachment" "alb_tg_attach_images" {
  target_group_arn = aws_lb_target_group.alb_tg_images.arn
  target_id        = aws_instance.web_server_2.id
}

resource "aws_lb_target_group_attachment" "alb_tg_attach_register" {
  target_group_arn = aws_lb_target_group.alb_tg_register.arn
  target_id        = aws_instance.web_server_3.id # Corrected to a distinct instance
}
