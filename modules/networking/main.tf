data "aws_availability_zones" "available" {}

# Creates a VPC
resource "aws_vpc" "demo2vpc" { 
  cidr_block = var.cidr
  tags = {
    Name = "${var.application_name}-VPC"
  }
}

# Creates 2 public subnets in the VPC
resource "aws_subnet" "both_public_subnets" {
  count = length(var.public_subnets_list)

  vpc_id = var.id_vpc
  cidr_block = var.public_subnets_list[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.application_name}-Public-Subnets"
  }
}

# Creates 2 private subnets in the VPC
resource "aws_subnet" "both_private_subnets" {
  count = length(var.private_subnets_list)

  vpc_id = var.id_vpc
  map_public_ip_on_launch = true
  cidr_block = var.private_subnets_list[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
      Name = "${var.application_name}-Private-Subnets"
  }
}

# Creates an Internet Gateway in the VPC for internet connection
resource "aws_internet_gateway" "ig" {
  vpc_id = var.id_vpc
  tags = {
    Name = "${var.application_name}-Internet-Gateway"
  }
}

# Creates 2 Elastic IPs so the NAT gateways can have static IPs
resource "aws_eip" "elastic_ip" {
  count = var.just_count
  vpc = true
  depends_on = [aws_internet_gateway.ig]
  tags = {
    Name = "${var.application_name}-Elastic-IPs"
  }
}

# Creates 2 NAT gateways in each of the public subnets
resource "aws_nat_gateway" "nat" {
  count = var.just_count
  subnet_id = element(aws_subnet.both_public_subnets.*.id, count.index)
  allocation_id = element(aws_eip.elastic_ip.*.id, count.index)
  tags = {
    Name = "${var.application_name}-NAT-Gateways"
  }
}

# Routes the traffic from the public subnet to the Internet Gateway
resource "aws_route_table" "public_routetable" {
  vpc_id = var.id_vpc

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.ig.id
  }

  depends_on = [aws_internet_gateway.ig]
  tags = {
    Name = "${var.application_name}-Public-RouteTable"
  }
}

resource "aws_route_table" "private_routetable" {
  count = var.just_count
  vpc_id = var.id_vpc

  route {
    cidr_block = var.route_cidr_block
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  depends_on = [aws_nat_gateway.nat]
  tags = {
    Name = "${var.application_name}-Private-RouteTable"
  }
}

resource "aws_route_table_association" "public_associations" {
  count = length(var.public_subnets_list)

  subnet_id = element(aws_subnet.both_public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_routetable.id
}

resource "aws_route_table_association" "private_associations" {
  count = length(var.private_subnets_list)

  subnet_id = element(aws_subnet.both_private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_routetable.*.id, count.index)
}