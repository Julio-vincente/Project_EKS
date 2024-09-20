### ZONES
variable "zone1a" {
  type = string
  default = "us-east-1a"
}

variable "zone1b" {
  type = string
  default = "us-east-1b"
}

### VPC PRODUCTION
variable "vpc_name_production" {
  type = string
  default = "Production"
}

variable "cidr_production" {
    type = string
    default = "10.0.0.0/16"
}

### NAME SUBNET PRODUCTION ZONE 1a
variable "production_pub_1a" {
  type = string
  default = "prod_pub_1a"
}

variable "production_priv_1a" {
  type = string
  default = "prod_priv_1a"
}

### CIDR SUBNETS PRODUCTION 1a
variable "cidr_prod_pub_1a" {
  type = string
  default = "10.0.1.0/24"
}

variable "cidr_prod_priv_1a" {
  type = string
  default = "10.0.2.0/24"
}

### NAME SUBNET PRODUCTION ZONE 1b
variable "production_pub_1b" {
  type = string
  default = "prod_pub_1b"
}

variable "production_priv_1b" {
  type = string
  default = "prod_priv_1b"
}

### CIDR SUBNETS PRODUCTION 1b
variable "cidr_prod_pub_1b" {
  type = string
  default = "10.0.3.0/24"
}

variable "cidr_prod_priv_1b" {
  type = string
  default = "10.0.4.0/24"
}

### INTERNET GATEWAY PRODUCTION
variable "Name_IGW" {
  type = string
  default = "IGW_Production"
  
}

### NAT GATEWAY PRODUCTION
variable "Name_NatGW" {
  type = string
  default = "Nat_Gateway"
}

### ROUTE TABLE PUBLIC
variable "Name_RT_Public" {
  type = string
  default = "RT-PUBLIC"
}

### ROUTE TABLE PRIVATE
variable "Name_RT_Private" {
  type = string
  default = "RT-PRIVATE"
}
