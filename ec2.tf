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