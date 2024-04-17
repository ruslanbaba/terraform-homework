resource "aws_instance" "ec2_instances" {
    for_each = { for instance in var.ec2_instances : instance.name => instance }

    ami           = each.value.ami
    instance_type = each.value.instance_type
    key_name      = "BastionKey"
    subnet_id     = aws_subnet.subnets[each.key].id
    security_groups = [aws_security_group.kaizen_sg.name]

    tags = {
        Name = each.key
    }

    provisioner "file" {
        source      = each.key == "Ubuntu" ? "apache-ubuntu.sh" : "apache-linux.sh"
        destination = "/tmp/setup.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/setup.sh",
            "/tmp/setup.sh"
        ]
    }
}
