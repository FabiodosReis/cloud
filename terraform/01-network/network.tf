resource "aws_vpc" "vpc_cloud" {

  cidr_block = var.network.cidr_block
  enable_dns_support = var.network.enable_dns_support
  enable_dns_hostnames = var.network.enable_dns_hostnames

  tags = {
    "Name" = "VPC-cloud"
  }

}

resource "aws_internet_gateway" "ig-cloud" {
  vpc_id = aws_vpc.vpc_cloud.id

  tags = {
    "Name" = "IG-cloud"
  }

}