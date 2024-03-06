#sg for alb
resource "aws_security_group" "sg_alb" {
  name        = "sg_alb"
  description = "allows all traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "sg_alb"
  }

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#sg for instance
resource "aws_security_group" "sg_instance" {
  name        = "sg_instance"
  description = "allows all traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "sg_instance"
  }
  ingress {
    description     = "http from 5000 only from alb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_alb.id}"]
  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "allow port 5000 from alb"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_alb.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "sg_rds" {
  name        = "sg_rds"
  description = "allow traffic from instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }
}
