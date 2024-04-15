resource "aws_instance" "ec2_instances" {
    count = length(var.ec2_instances)

    ami          = element(var.ec2_instances, count.index).ami
    instance_type = element(var.ec2_instances, count.index).instance_type
    key_name     = "BastionKey"
    subnet_id    = element(aws_subnet.subnets, count.index).id
    security_groups = [aws_security_group.kaizen_sg.name]

    tags = {
        Name = element(var.ec2_instances, count.index).name
    }

    provisioner "file" {
        source      = count.index == 0 ? "apache-ubuntu.sh" : "apache-linux.sh"
        destination = "/tmp/setup.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/setup.sh",
            "/tmp/setup.sh"
        ]
    }
}
