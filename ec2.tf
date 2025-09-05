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

              #sudo rm -rf | sudo tee -a /usr/share/nginx/html/index.html
              echo "<h1>Home - Page!</h1>" | sudo tee -a /usr/share/nginx/html/index.html

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

              mkdir /usr/share/nginx/html/images
              echo "<h1>Images!</h1>" | sudo tee -a /usr/share/nginx/html/images/index.html

              sudo chown -R nginx:nginx /usr/share/nginx/html/images
              sudo chmod -R 755 /usr/share/nginx/html/images
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

              mkdir usr/share/nginx/html/register
              echo "<h1>Register!</h1>" | sudo tee -a /usr/share/nginx/html/register/index.html

              sudo chown -R nginx:nginx /usr/share/nginx/html/register
              sudo chmod -R 755 /usr/share/nginx/html/register
              EOF

  tags = {
    Name = "WebServer-sub-3"
  }
}