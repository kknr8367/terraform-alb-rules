resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  
  tags = {
    Name = "alb-vpc"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "alb-public-subnet1"
  }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "alb-public-subnet2"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "alb-public-subnet3"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "alb-igw"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "alb-public-rt"
  }
}
resource "aws_route_table_association" "public_associate1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_associate2" {
    subnet_id      = aws_subnet.public_subnet2.id
      route_table_id = aws_route_table.public.id
    }

resource "aws_route_table_association" "public_associate3" {
    subnet_id      = aws_subnet.public_subnet3.id
      route_table_id = aws_route_table.public.id
    }