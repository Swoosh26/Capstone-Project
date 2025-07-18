    # Create Security Group for the Application Load Balancer
    # terraform aws create security group
    resource "aws_security_group" "alb-security-group" {
      name        = "alb-security-group"
      description = "ALB Security Group"
      vpc_id      = aws_vpc.vpc.id

      ingress {
        description = "Allow HTTP traffic from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        description = "Allow HTTPS traffic from anywhere"
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

      tags = {
        Name = "ALB Security Group"
      }
    }

    # Create Security Group for the Bastion Host aka Jump Box
    # terraform aws create security group
    resource "aws_security_group" "ssh-security-group" {
      count       = var.enable_bastion ? 1 : 0
      name        = "ssh-security-group"
      description = "SSH Security Group for Bastion Host"
      vpc_id      = aws_vpc.vpc.id

      ingress {
        description = "Allow SSH traffic from specific IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.my_public_ip}"] # Replace with your IP address 
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic 
      }

      tags = {
        Name = "${var.project_name}-bastion-sg"
      }
    }

    # Create Security Group for the Web Server
    # terraform aws create security group
    resource "aws_security_group" "webserver-security-group" {
      name        = "webserver-security-group"
      description = "Enable HTTP and HTTPS traffic on port 80 and 443 via ALB and SSH traffic on port 22 via SSH Security Group"
      vpc_id      = aws_vpc.vpc.id

      ingress {
        description     = "Allow HTTP traffic from ALB"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = ["${aws_security_group.alb-security-group.id}"] # Allow traffic from ALB
      }

      ingress {
        description     = "Allow HTTPS traffic from ALB"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = ["${aws_security_group.alb-security-group.id}"] # Allow traffic from ALB
      }

      ingress {
        description     = "Allow SSH traffic from Bastion Host"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = ["${aws_security_group.ssh-security-group.id}"] # Allow traffic from Bastion Host
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic 
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags = {
        Name = "Web Server Security Group"
      }
    }

    # Create Security Group for the Database
    # terraform aws create security group
    resource "aws_security_group" "database-security-group" {
      name        = "database-security-group"
      description = "Enable MYSQL Aurora traffic on port 3306 via Web Server Security Group"
      vpc_id      = aws_vpc.vpc.id

      ingress {
        description     = "Allow MySQL/Aurora traffic from Web Server"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = ["${aws_security_group.webserver-security-group.id}"] # Allow traffic from Web Server
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic 
        cidr_blocks = ["0.0.0.0/0"]
      }
      tags = {
        Name = "Database Security Group"
      }
    }

    #Create Security Group For EFS
    # terraform aws create security group
    resource "aws_security_group" "efs-security-group" {
      name        = "efs-security-group"
      description = "Enable NFS traffic on port 2049 via Web Server Security Group"
      vpc_id      = aws_vpc.vpc.id

      ingress {
        description     = "Allow NFS traffic from Web Server"
        from_port       = 2049
        to_port         = 2049
        protocol        = "tcp"
        security_groups = ["${aws_security_group.webserver-security-group.id}"] # Allow traffic from Web Server
      }

     
      ingress {
        description     = "Allow traffic from EFS Security Group itself"
        from_port       = 2049
        to_port         = 2049
        protocol        = "tcp"
        security_groups = ["${aws_security_group.efs-security-group.id}"] # Allow traffic from EFS Security Group itself
      }
      
      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic 
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags = {
        Name = "EFS Security Group"
      }
    }