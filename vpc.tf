#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "fyp" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-fyp-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "fyp" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.fyp.id

  tags = tomap({
    "Name"                                      = "terraform-eks-fyp-node-public",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "fyp" {
  vpc_id = aws_vpc.fyp.id

  tags = {
    Name = "terraform-eks-fyp"
  }
}

resource "aws_route_table" "fyp" {
  vpc_id = aws_vpc.fyp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fyp.id
  }
}

resource "aws_route_table_association" "fyp" {
  count = 2

  subnet_id      = aws_subnet.fyp.*.id[count.index]
  route_table_id = aws_route_table.fyp.id
}

