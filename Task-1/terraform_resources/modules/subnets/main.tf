resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.public_subnets_cidrs : idx => subnet }

  #count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  #cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  #availability_zone       = var.azs[count.index]

  tags = {
    #Name = "Public-Subnet-${count.index + 1}-${var.environment}"
    Name = "Public-Subnet-${each.key}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "Private-Subnet-${count.index + 1}-${var.environment}"
  }
}

