resource "aws_subnet" "subnets" {
    for_each = { for subnet in var.subnets : subnet.name => subnet }

    vpc_id            = aws_vpc.kaizen.id
    cidr_block        = each.value.cidr_block
    availability_zone = each.value.az
    tags = {
        Name = each.key
    }
}

resource "aws_route_table_association" "public_subnet_associations" {
    for_each = { for subnet in aws_subnet.subnets : subnet.key => subnet.value if subnet.value.tags["Name"] == "public1" || subnet.value.tags["Name"] == "public2" }

    subnet_id      = each.value.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_associations" {
    for_each = { for subnet in aws_subnet.subnets : subnet.key => subnet.value if subnet.value.tags["Name"] == "private1" || subnet.value.tags["Name"] == "private2" }

    subnet_id      = each.value.id
    route_table_id = aws_route_table.private_rt.id
}
