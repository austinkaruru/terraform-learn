output "ec2_public_ip" {
  # The public IP address assigned to your EC2 instance.
  value       = module.myapp-server.instance.public_ip
  description = "The public IP address of the EC2 instance"
}
