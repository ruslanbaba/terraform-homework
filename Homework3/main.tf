provider "aws" {
    region = "us-west-2"
}

resource "aws_security_group" "allow_tls" {
    name        = "allow_tls"
    description = "For TLS inbound access"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
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

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnets" {
    count = 3

    vpc_id = aws_vpc.main.id
    cidr_block = element(
        ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"],
        count.index
    )
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_instance" "web" {
    count        = 3
    ami          = "ami-0c55b159cbfafe1f0" 
    instance_type = "t2.micro"
    key_name     = aws_key_pair.bastion_key.key_name
    subnet_id    = element(aws_subnet.subnets[*].id, count.index)
    tags = {
        Name = "web-${count.index + 1}"
    }
    security_groups = [aws_security_group.allow_tls.name] # Attached the security group to instances

    provisioner "remote-exec" {
        connection {
            type        = "ssh"
            user        = "ec2-user"
            private_key = file("~/.ssh/BastionKey.pem")
            host        = aws_instance.web[count.index].public_ip
        }

        inline = [
            "sudo yum update -y",
            "sudo yum install -y httpd",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "echo 'Hello, World!' | sudo tee /var/www/html/index.html"
        ]
    }
}

