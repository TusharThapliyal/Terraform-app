resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [var.private_subnet_id[0], var.private_subnet_id[1]]
}

resource "aws_db_instance" "my_db_instance" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  username                = "admin"
  password                = "password"
  db_subnet_group_name    = aws_db_subnet_group.my_subnet_group.name
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
  # multi_az                = false
}

# output "db_instance_endpoint" {
#   value = aws_db_instance.my_db_instance.endpoint
# }
