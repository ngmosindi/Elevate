resource "aws_subnet" "alb_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.alb_subnet_cidr
  availability_zone       = var.availability_zone_names
  map_public_ip_on_launch = true
}

resource "aws_subnet" "web_subnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.web_subnet1_cidr
  availability_zone       = var.availability_zone_names
  map_public_ip_on_launch = false
}
resource "aws_subnet" "web_subnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.web_subnet2_cidr
  availability_zone       = var.availability_zone_names
  map_public_ip_on_launch = false
}

  resource "aws_subnet" "app_subnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.app_subnet1_cidr
  availability_zone       = var.availability_zone_names
  map_public_ip_on_launch = false
  }

resource "aws_subnet" "app_subnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.app_subnet2_cidr
  availability_zone       = var.availability_zone_names
  map_public_ip_on_launch = false
  }

  #Create Database Private Subnet
resource "aws_subnet" "database_subnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.database_subnet1_cidr
  availability_zone = var.availability_zone_names
}

resource "aws_subnet" "database_subnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.database_subnet2_cidr
  availability_zone = var.availability_zone_names
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.database_subnet1.id, aws_subnet.database_subnet2.id]
  tags = {
    Name = "My DB subnet group"
  }
}
