variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "bastion_subnet_id" {
  type = string
}

variable "private_subnet_a_id" {
  type = string
}

variable "private_subnet_b_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(any)
}