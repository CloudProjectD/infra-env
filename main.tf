terraform {
  backend "s3" {
    bucket = "khu-market-dusdj-0813"
    key    = "kyunghee-market/backend"
    region = "us-east-1"
  }
}

locals {
  env_name   = "kyunghee-market"
  aws_region = "us-east-1"
}