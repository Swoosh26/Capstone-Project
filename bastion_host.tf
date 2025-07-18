# Create Bastion Host (Optional)
# terraform aws create instance
resource "aws_instance" "bastion" {
  count                  = var.enable_bastion ? 1 : 0
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name              = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  subnet_id             = aws_subnet.public-subnet-1.id

  tags = {
    Name = "${var.project_name}-bastion"
  }
}
