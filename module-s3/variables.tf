variable "aws_region" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "block_public_acls" {
  type = bool
}

variable "block_public_policy" {
  type = bool
}

variable "ignore_public_acls" {
  type = bool
}

variable "restrict_public_buckets" {
  type = bool
}