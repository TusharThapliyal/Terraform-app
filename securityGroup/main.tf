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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#sg for instance
resource "aws_security_group" "sg_instance" {
  name        = "sg_alb"
  description = "allows all traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "sg_instance"
  }
  ingress {
    description     = "http from 5000 only from alb"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_alb.id]
  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
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
