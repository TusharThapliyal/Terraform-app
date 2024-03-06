# vpc
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "main_vpc"
  }
}
#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_subnets[0]
  availability_zone = element(var.az, 0)
  tags = {
    Name = "public_subet"
  }
}

#private_subnet
resource "aws_subnet" "private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(var.cidr_subnets, count.index + 1)
  availability_zone = element(var.az, count.index + 1)
  tags = {
    Name = "private_subet"
  }
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

#route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

#route table association
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
