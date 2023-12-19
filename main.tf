terraform {
  backend "s3" {
    bucket = "khu-market-tf-0813"
    key    = "kyunghee-market/backend"
    region = "us-east-1"
  }
}

locals {
  env_name   = "kyunghee-market"
  aws_region = "us-east-1"
}

module "vpc" {
  source = "./module-network"

  aws_region = local.aws_region
  env_name   = local.env_name

  vpc_name              = "khu-vpc"
  public_subnet_a_cidr  = "10.0.0.0/18"
  public_subnet_b_cidr  = "10.0.64.0/18"
  private_subnet_a_cidr = "10.0.128.0/19"
  private_subnet_b_cidr = "10.0.160.0/19"
  private_subnet_c_cidr = "10.0.192.0/19"
  private_subnet_d_cidr = "10.0.224.0/19"
}

module "ec2" {
  source = "./module-ec2"

  aws_region = local.aws_region
  env_name   = local.env_name

  vpc_id             = module.vpc.vpc_id
  bastion_subnet_id  = module.vpc.public_subnet_ids[0]
  private_subnet_ids = module.vpc.asg_private_subnet_ids
}

module "s3" {
  source = "./module-s3"

  aws_region  = local.aws_region
  bucket_name = "khu-market-202312"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

module "dynamodb" {
  source = "./module-dynamodb"

  aws_region          = local.aws_region
  dynamodb_table_name = "khu-market-ddb"
}

module "rds" {
  source = "./module-rds"

  aws_region = local.aws_region

  db_name       = "kyunghee-market-db"
  db_subnet_ids = module.vpc.db_private_subnet_ids
  db_username   = "admin"
  db_password   = "kyunghee1234!"
}
