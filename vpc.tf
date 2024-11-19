terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.20.20.0/26"
  instance_tenancy = "default"

  tags = {
    Name = "loadbalancer"
  }
}

resource "aws_subnet" "aws_public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.20.0/28"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "aws_public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.20.16/28"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "aws_private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.20.32/28"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "aws_private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.20.48/28"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private2"
  }
}

resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  depends_on = [ aws_vpc.main ]
  
  tags = {
    Name = "effex-rtb"
  }
}

resource "aws_route" "internet" {
  route_table_id = aws_route_table.public-rtb.id
  gateway_id = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "robert-gw"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.aws_public1.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.aws_public2.id
  route_table_id = aws_route_table.public-rtb.id
}



