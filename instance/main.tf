resource "aws_instance" "app-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "app-server"
  }
}
