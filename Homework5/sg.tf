resource "aws_security_group" "kaizen_sg" {
    vpc_id = aws_vpc.kaizen.id
    name   = "kaizen_sg"

    ingress {
        from_port   = var.ports.ssh
        to_port     = var.ports.ssh
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = var.ports.http
        to_port     = var.ports.http
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
