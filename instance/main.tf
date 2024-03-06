resource "aws_instance" "app-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  tags = {
    Name = "app-server"
  }
}
