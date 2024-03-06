resource "aws_instance" "app-server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  user_data                   = var.user_data
  key_name                    = jenkins_demo
  vpc_security_group_ids      = [var.sg_instance]
  tags = {
    Name = "app-server"
  }
}
