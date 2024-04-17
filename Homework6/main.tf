terraform {
    backend "s3" {
        bucket         = "terraform-state-bucket"
        key            = "terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "terraform-lock-table"
        encrypt        = true
    }
}

resource "aws_instance" "ubuntu_instance" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name      = var.key_name
    tags = {
        Name = "Ubuntu-Instance"
    }

    provisioner "file" {
        source      = "apache.sh"
        destination = "/tmp/apache.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/apache.sh",
            "/tmp/apache.sh"
        ]
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"] #

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
}
