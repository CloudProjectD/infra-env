provider "aws" {
  region = var.aws_region
}

# ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# bastion host ec2 instance
resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = var.bastion_subnet_id
  key_name      = "vockey1"

  tags = {
    Name = "${var.env_name}-bastion"
  }
}

# eip
resource "aws_eip" "bastion" {
  instance = aws_instance.bastion-host.id
  domain   = "vpc"
}

# security groups
resource "aws_security_group" "bastion-sg" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg-alb-sg" {
  name   = "asg-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg-bastion-sg" {
  name   = "asg-bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# auto scaling group
resource "aws_launch_configuration" "khu-launch-config" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.asg-alb-sg.id, aws_security_group.asg-bastion-sg.id]
  key_name        = "vockey2"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "khu-asg" {
  launch_configuration = aws_launch_configuration.khu-launch-config.name
  vpc_zone_identifier  = var.private_subnet_ids

  target_group_arns = [aws_lb_target_group.khu-alb-tg.arn]
  # lb tg가 생성되어 arn이 지정된 후 사용 가능하므로 
  depends_on        = [aws_lb_target_group.khu-alb-tg]
  health_check_type = "ELB"

  desired_capacity = 2
  min_size         = 2
  max_size         = 5
}
