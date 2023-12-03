provider "aws" {
  region = var.aws_region
}

locals {
  vpc_name = "${var.env_name} ${var.vpc_name}"
}

# vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = local.vpc_name
  }
}

# subnet
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = ("${local.vpc_name}-public-subnet-a")
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = ("${local.vpc_name}-public-subnet-b")
  }
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = ("${local.vpc_name}-private-subnet-a")
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = ("${local.vpc_name}-private-subnet-b")
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_c_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = ("${local.vpc_name}-private-subnet-c")
  }
}

resource "aws_subnet" "private-subnet-d" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_d_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = ("${local.vpc_name}-private-subnet-d")
  }
}

# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.vpc_name}-igw"
  }
}

