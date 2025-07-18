# Create Database Subnet Groups
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database-subnet-group"
  description  = "Database Subnet Group for RDS Instances"
  subnet_ids   = [
    aws_subnet.private-subnet-3.id,
    aws_subnet.private-subnet-4.id
  ] 

  tags   = {
    Name = "Database Subnet Group"
  }
}

# Create Database Instance
# terraform aws db instance
resource "aws_db_instance" "rds-instance" {
  identifier              = "rds-instance"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.database-subnet-group.name
  vpc_security_group_ids  = [aws_security_group.database-security-group.id]
  username                = ["${var.db_username}"]
  password                = ["${var.db_password}"]
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags   = {
    Name = "RDS Instance"
  }
}