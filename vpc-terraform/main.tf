provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main_vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_3"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1c"
  tags = {
    Name = "private_subnet_3"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Private Route Tables
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private_route_table_1"
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private_route_table_2"
  }
}

resource "aws_route_table" "private_route_table_3" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private_route_table_3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_internet_gateway"
  }
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_1" {
  vpc = true
}

resource "aws_eip" "nat_eip_2" {
  vpc = true
}

resource "aws_eip" "nat_eip_3" {
  vpc = true
}

# NAT Gateways
resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.main_gateway]
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  depends_on    = [aws_internet_gateway.main_gateway]
}

resource "aws_nat_gateway" "nat_gateway_3" {
  allocation_id = aws_eip.nat_eip_3.id
  subnet_id     = aws_subnet.public_subnet_3.id
  depends_on    = [aws_internet_gateway.main_gateway]
}
