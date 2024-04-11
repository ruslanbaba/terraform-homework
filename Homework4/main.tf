provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  count             = var.instance_count
  availability_zone = var.az
  security_groups   = [aws_security_group.allow_tls.name]
  tags = {
    Name = "ec2 in ${var.az}"
  }
}