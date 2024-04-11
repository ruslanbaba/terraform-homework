provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "web" {
    count = 3
    ami = "ami-0c55b159cbfafe1f0" #AM 2 ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.bastion_key.key_name
    subnet_id = element(aws_subnet.subnets[*].id, count.index)
    tags = {
        Name = "web-${count.index + 1}"
    }

}

resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "Security group for web instances"


ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "BastionKey"
  public_key = file("~/.ssh/BastionKey.pub")
}

resource "aws_subnet" "subnets" {
  count = 3

  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.subnet_cidr_blocks, count.index)

  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "null_resource" "install_apache" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/BastionKey.pen")
    host        = aws_instance.web[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "echo 'Hello, World!' | sudo tee /var/www/html/index.html"
    ]
  }

  depends_on = [aws_instance.web]
}