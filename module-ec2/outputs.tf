output "bastion_public_ip" {
  description = "Public IP address of the bastion host."
  value       = aws_eip.bastion.public_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.khu-alb.dns_name
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group."
  value       = aws_autoscaling_group.khu-asg.name
}