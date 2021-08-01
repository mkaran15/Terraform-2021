resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.vpc_name}"
  }
}

output "aws_vpc_id"{
    value = aws_vpc.vpc.id
}