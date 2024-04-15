resource "aws_vpc" "kaizen" {
    cidr_block            = var.vpc_config.cidr_block
    enable_dns_support    = var.vpc_config.enable_dns_support
    enable_dns_hostnames  = var.vpc_config.enable_dns_hostnames
}

resource "aws_internet_gateway" "kaizen" {
    vpc_id = aws_vpc.kaizen.id
    tags = {
        Name = var.internet_gateway_name
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.kaizen.id
    tags = {
        Name = var.route_table_names.public_rt
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.kaizen.id
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.kaizen.id
    tags = {
        Name = var.route_table_names.private_rt
    }
}
