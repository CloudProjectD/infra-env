variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnet_a_cidr" {
  type = string
}

variable "public_subnet_b_cidr" {
  type = string
}

variable "private_subnet_a_cidr" {
  type = string
}

variable "private_subnet_b_cidr" {
  type = string
}

variable "private_subnet_c_cidr" {
  type = string
}

variable "private_subnet_d_cidr" {
  type = string
}