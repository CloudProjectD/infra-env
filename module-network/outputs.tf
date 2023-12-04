output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public-subnet-a.id,
    aws_subnet.public-subnet-b.id,
    aws_subnet.private-subnet-a.id,
    aws_subnet.private-subnet-b.id,
    aws_subnet.private-subnet-c.id,
    aws_subnet.private-subnet-d.id,
  ]
}

output "asg_private_subnet_ids" {
  value = [
    aws_subnet.private-subnet-a.id,
    aws_subnet.private-subnet-b.id,
  ]
}

output "db_private_subnet_ids" {
  value = [
    aws_subnet.private-subnet-c.id,
    aws_subnet.private-subnet-d.id,
  ]
}

output "public_subnet_ids" {
  value = [aws_subnet.public-subnet-a.id, aws_subnet.public-subnet-b.id]
}