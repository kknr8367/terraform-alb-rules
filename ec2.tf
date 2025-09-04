resource "aws_instance" "web_server_1" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet1.id 
  #key_name      = "k8s.pem" 
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  associate_public_ip_address = true

 user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx

              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
              SUBNET_NAME="Public Subnet 1"

              echo "<html>" | sudo tee /usr/share/nginx/html/index.html
              echo "<body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Hello from EC2 Instance 1 Using the Subnet 1!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Instance ID: $INSTANCE_ID</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Public IP: $PUBLIC_IP</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Home - Page!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Availability Zone: $AVAILABILITY_ZONE</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Running in: $SUBNET_NAME</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</html>" | sudo tee -a /usr/share/nginx/html/index.html

              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF


  tags = {
    Name = "WebServer-sub-1"
  }
}

resource "aws_instance" "web_server_2" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet2.id 
  #key_name      = "k8s.pem" 
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  associate_public_ip_address = true

   user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx

              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
              SUBNET_NAME="Public Subnet 1"

              echo "<html>" | sudo tee /usr/share/nginx/html/index.html
              echo "<body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Hello from EC2 Instance 1 Using the Subnet 1!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Instance ID: $INSTANCE_ID</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Public IP: $PUBLIC_IP</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Images!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Availability Zone: $AVAILABILITY_ZONE</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Running in: $SUBNET_NAME</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</html>" | sudo tee -a /usr/share/nginx/html/index.html

              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF

  tags = {
    Name = "WebServer-sub-2"
  }
}

resource "aws_instance" "web_server_3" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet3.id 
  #key_name      = "k8s.pem" 
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  associate_public_ip_address = true

   user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx.x86_64
              sudo systemctl start nginx
              sudo systemctl enable nginx

              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
              SUBNET_NAME="Public Subnet 1"

              echo "<html>" | sudo tee /usr/share/nginx/html/index.html
              echo "<body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Hello from EC2 Instance 1 Using the Subnet 1!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Instance ID: $INSTANCE_ID</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Public IP: $PUBLIC_IP</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Register!</h1>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Availability Zone: $AVAILABILITY_ZONE</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "<p>Running in: $SUBNET_NAME</p>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</body>" | sudo tee -a /usr/share/nginx/html/index.html
              echo "</html>" | sudo tee -a /usr/share/nginx/html/index.html

              sudo chown -R nginx:nginx /usr/share/nginx/html
              sudo chmod -R 755 /usr/share/nginx/html
              EOF

  tags = {
    Name = "WebServer-sub-3"
  }
}

# --- ALB Resources ---
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
