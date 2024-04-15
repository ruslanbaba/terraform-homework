resource "aws_subnet" "subnets" {
    count = length(var.subnets)

    vpc_id            = aws_vpc.kaizen.id
    cidr_block        = element(var.subnets, count.index).cidr_block
    availability_zone = element(var.subnets, count.index).az
    tags = {
        Name = element(var.subnets, count.index).name
    }
}

resource "aws_route_table_association" "public_subnet_associations" {
    count = 2

    subnet_id      = element(aws_subnet.subnets[*], count.index).id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_associations" {
    count = 2

    subnet_id      = element(aws_subnet.subnets, count.index + 2).id
    route_table_id = aws_route_table.private_rt.id
}
