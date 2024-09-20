### VPC PRODUCTION
resource "aws_vpc" "vpc-production" {
  cidr_block = var.cidr_production
  tags = {
    Name = var.vpc_name_production
  }
}

### SUBNETS PRODUCTION 1a
resource "aws_subnet" "subnet-production-pub-1a" {
  vpc_id            = aws_vpc.vpc-production.id
  cidr_block        = var.cidr_prod_pub_1a
  availability_zone = var.zone1a
  tags = {
    Name = var.production_pub_1a
  }
}

resource "aws_subnet" "subnet_production_priv_1a" {
  vpc_id = aws_vpc.vpc-production.id
  cidr_block = var.cidr_prod_priv_1a
  availability_zone = var.zone1a
  tags = {
    Name = var.production_priv_1a
  }
}

### SUBNETS PRODUCTION 1b
resource "aws_subnet" "subnet-production-pub-1b" {
  vpc_id            = aws_vpc.vpc-production.id
  cidr_block        = var.cidr_prod_pub_1b
  availability_zone = var.zone1b
  tags = {
    Name = var.production_pub_1b
  }
}

resource "aws_subnet" "subnet_production_priv_1b" {
  vpc_id = aws_vpc.vpc-production.id
  cidr_block = var.cidr_prod_priv_1b
  availability_zone = var.zone1b
  tags = {
    Name = var.production_priv_1b
  }
}

### IGW PRODUCTION
resource "aws_internet_gateway" "IGW-Prod" {
  vpc_id = aws_vpc.vpc-production.id
  tags = {
    Name = var.Name_IGW
  }
}

### NAT GATEWAY PRODUCTION
resource "aws_eip" "eip-production" {}

resource "aws_nat_gateway" "nat-gateway-production" {
  allocation_id = aws_eip.eip-production.id
  subnet_id     = aws_subnet.subnet-production-pub-1a.id
  tags = {
    Name = var.Name_NatGW
  }
}

### ROUTE TABLE PUBLIC PRODUCTION
resource "aws_route_table" "RT-PUBLIC" {
  vpc_id = aws_vpc.vpc-production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-Prod.id
  }

  tags = {
    Name = var.Name_RT_Public
  }
}

resource "aws_route_table_association" "Association_Public" {
  for_each = {
    subnet1 = aws_subnet.subnet-production-pub-1a.id
    subnet2 = aws_subnet.subnet-production-pub-1b.id
  }
  
  subnet_id = each.value
  route_table_id = aws_route_table.RT-PUBLIC.id
}

### ROUTE TABLE PRIVATE PRODUCTION
resource "aws_route_table" "RT-PRIVATE" {
  vpc_id = aws_vpc.vpc-production.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-production.id
  }
  
  tags = {
    Name = var.Name_RT_Private
  }

  depends_on = [ aws_nat_gateway.nat-gateway-production ]
}

resource "aws_route_table_association" "Association_Private" {
  for_each = {
    subnet1 = aws_subnet.subnet_production_priv_1a.id
    subnet2 = aws_subnet.subnet_production_priv_1b.id
  }
  
  subnet_id = each.value
  route_table_id = aws_route_table.RT-PRIVATE.id

  depends_on = [ aws_route_table.RT-PRIVATE ]
}