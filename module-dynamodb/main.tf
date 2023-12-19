provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "khu-dynamo-table" {
  name           = var.dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  range_key      = "created_at"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  tags = {
    Name = "${var.dynamodb_table_name}"
  }
}