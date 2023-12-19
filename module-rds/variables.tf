variable "aws_region" {
  type = string
}

variable "db_subnet_ids" {
  type = list(any)
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}