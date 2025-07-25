# cria uma VPC de id 10.0.0.0/16 com 4 subnets nessa reda
# Cria cria um internet gateway
# Cria 2 subnets publicas e 2 subnets privadas
# Cria uma tabela de roteamento para associar as subnets com os componentes de rede
# Faz a associacao das subnets privadas com a rede local e faz a associacao das subnets e publicas com o internet gateway


resource "random_id" "suffix" {
  byte_length = 2
}

resource "aws_vpc" "vpc_cloud" {
  cidr_block = var.network.cidr_block
  enable_dns_support = var.network.enable_dns_support
  enable_dns_hostnames = var.network.enable_dns_hostnames

  tags = {
    "Name" = "vpc-cloud-${random_id.suffix.hex}"
  }

}

resource "aws_internet_gateway" "ig_cloud" {
  vpc_id = aws_vpc.vpc_cloud.id

  tags = {
    "Name" = "ig-cloud-${random_id.suffix.hex}"
  }
}

resource "aws_subnet" "subnet-public" {
  count = var.network.az_count
  vpc_id = aws_vpc.vpc_cloud.id
  cidr_block = cidrsubnet(aws_vpc.vpc_cloud.cidr_block,8, var.network.az_count + count.index )
  availability_zone = local.selected_vailability_zones[count.index]

  tags = {
    "Name" = "subnet-public-${random_id.suffix.hex}"
  }
}


resource "aws_subnet" "subnet-private" {
  count = var.network.az_count
  vpc_id = aws_vpc.vpc_cloud.id
  cidr_block = cidrsubnet(aws_vpc.vpc_cloud.cidr_block,8,count.index )
  availability_zone = local.selected_vailability_zones[count.index]

  tags = {
    "Name" = "subnet-private-${random_id.suffix.hex}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_cloud.id

  route {
    cidr_block = var.network.cidr_internet
    gateway_id = aws_internet_gateway.ig_cloud.id
  }

  route {
    cidr_block = var.network.cidr_block
    gateway_id = "local"
  }

  tags = {
    "Name" = "rtb-cloud-public-${random_id.suffix.hex}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc_cloud.id

  route {
    cidr_block = var.network.cidr_block
    gateway_id = "local"
  }

  tags = {
    "Name" = "rtb-cloud-private-${random_id.suffix.hex}"
  }
}

resource "aws_route_table_association" "public" {
  count = var.network.az_count
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.subnet-public.*.id[count.index]
}

resource "aws_route_table_association" "private" {
  count = var.network.az_count
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.subnet-private.*.id[count.index]
}

