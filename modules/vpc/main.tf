resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "$[var.environment]-vpc"
    }
}

resource "aws_internet_gateway" "main_gateway" {
    vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "main_public_subnet" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "$[var.environment]-public-subnet-{count.index + 1}"
    }
}

resource "aws_subnet" "main_private_subnet" {
    count             = length(var.private_subnet_cidrs)
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "$[var.environment]-private-subnet-{count.index + 1}"
    }
}

resource "aws_route_table" "main_public_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_gateway.id
    }
}

resource "aws_route_table_association" "main_public_assoc" {
    count          = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.main_public_subnet[count.index].id
    route_table_id = aws_route_table.main_public_rt
}

resource "aws_route_table" "main_private_rt" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "main_private_assoc" {
    count          = length(var.private_subnet_cidrs)
    subnet_id      = aws_subnet.main_private_subnet[count.index].id
    route_table_id = aws_route_table.main_private_rt
}