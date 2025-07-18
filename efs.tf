#Create EFS File
# terraform aws efs file system
resource "aws_efs_file_system" "efs-file-system" {
  creation  = "2023-10-01T00:00:00Z"
  performance_mode = "generalPurpose"
    encrypted = true
    tags = {
      Name = "EFS File System"
    }
}   
# Create EFS Mount Target in Private Subnet 3
# terraform aws efs mount target
resource "aws_efs_mount_target" "efs-mount-target-1" {
  file_system_id = aws_efs_file_system.efs-file-system.id
  subnet_id      = aws_subnet.private-subnet-3.id
  security_groups = [aws_security_group.efs-security-group.id]

  tags = {
    Name = "EFS Mount Target 1"
  }
}
# Create EFS Mount Target in Private Subnet 4
# terraform aws efs mount target    
resource "aws_efs_mount_target" "efs-mount-target-2" {
  file_system_id = aws_efs_file_system.efs-file-system.id
  subnet_id      = aws_subnet.private-subnet-4.id
  security_groups = [aws_security_group.efs-security-group.id]

  tags = {
    Name = "EFS Mount Target 2"
  }
}   
