output "sg_alb" {
  value = aws_security_group.sg_alb.id
}
output "sg_instance" {
  value = aws_security_group.sg_instance.id
}
