### VPC PRODUCTION
resource "aws_vpc" "vpc_production" {
  cidr_block = var.cidr_production
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name_production
  }
}

### SUBNETS PRODUCTION 1a
resource "aws_subnet" "subnet_production_pub_1a" {
  vpc_id            = aws_vpc.vpc_production.id
  cidr_block        = var.cidr_prod_pub_1a
  availability_zone = var.zone1a
  map_public_ip_on_launch = true
  tags = {
    Name = var.production_pub_1a
  }
}

resource "aws_subnet" "subnet_production_priv_1a" {
  vpc_id            = aws_vpc.vpc_production.id
  cidr_block        = var.cidr_prod_priv_1a
  availability_zone = var.zone1a
  map_public_ip_on_launch = true
  tags = {
    Name = var.production_priv_1a
  }
}

### SUBNETS PRODUCTION 1b
resource "aws_subnet" "subnet_production_pub_1b" {
  vpc_id            = aws_vpc.vpc_production.id
  cidr_block        = var.cidr_prod_pub_1b
  availability_zone = var.zone1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.production_pub_1b
  }
}

resource "aws_subnet" "subnet_production_priv_1b" {
  vpc_id            = aws_vpc.vpc_production.id
  cidr_block        = var.cidr_prod_priv_1b
  availability_zone = var.zone1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.production_priv_1b
  }
}

### IGW PRODUCTION
resource "aws_internet_gateway" "IGW_Prod" {
  vpc_id = aws_vpc.vpc_production.id
  tags = {
    Name = var.Name_IGW
  }
}

### NAT GATEWAY PRODUCTION
resource "aws_eip" "eip_production" {}

resource "aws_nat_gateway" "nat_gateway_production" {
  allocation_id = aws_eip.eip_production.id
  subnet_id     = aws_subnet.subnet_production_pub_1a.id
  tags = {
    Name = var.Name_NatGW
  }
}

### ROUTE TABLE PUBLIC PRODUCTION
resource "aws_route_table" "RT_PUBLIC" {
  vpc_id = aws_vpc.vpc_production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_Prod.id
  }

  tags = {
    Name = var.Name_RT_Public
  }
}

resource "aws_route_table_association" "Association_Public" {
  for_each = {
    subnet1 = aws_subnet.subnet_production_pub_1a.id
    subnet2 = aws_subnet.subnet_production_pub_1b.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.RT_PUBLIC.id
}

### ROUTE TABLE PRIVATE PRODUCTION
resource "aws_route_table" "RT_PRIVATE" {
  vpc_id = aws_vpc.vpc_production.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_production.id
  }

  tags = {
    Name = var.Name_RT_Private
  }

  depends_on = [aws_nat_gateway.nat_gateway_production]
}

resource "aws_route_table_association" "Association_Private" {
  for_each = {
    subnet1 = aws_subnet.subnet_production_priv_1a.id
    subnet2 = aws_subnet.subnet_production_priv_1b.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.RT_PRIVATE.id

  depends_on = [aws_route_table.RT_PRIVATE]
}

# Criação Security Group dos Nodes
resource "aws_security_group" "NODES_SG" {
  name        = var.Name_sg_node
  description = var.Description_sg_node
  vpc_id      = aws_vpc.vpc_production.id
}

# Liberando Nodes para http
resource "aws_vpc_security_group_ingress_rule" "rule_node_http" {
  security_group_id = aws_security_group.NODES_SG.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Liberando Nodes para https
resource "aws_vpc_security_group_ingress_rule" "rule_node_https" {
  security_group_id = aws_security_group.NODES_SG.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Liberando Nodes se comunicar para a internet
resource "aws_vpc_security_group_egress_rule" "rule_node_outbound" {
  security_group_id = aws_security_group.NODES_SG.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Criação Security Group do RDS
resource "aws_security_group" "RDS_SG" {
  name        = var.Name_sg_rds
  description = var.Description_sg_rds
  vpc_id      = aws_vpc.vpc_production.id
}

# Liberando Mysql para o RDS
resource "aws_vpc_security_group_ingress_rule" "rule_rds_https" {
  security_group_id = aws_security_group.RDS_SG.id
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Liberando RDS se comunicar para a internet
resource "aws_vpc_security_group_egress_rule" "rule_rds_outbound" {
  security_group_id = aws_security_group.RDS_SG.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}