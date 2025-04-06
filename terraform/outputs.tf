output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.devops_vm.public_ip
}

output "ssh_key_path" {
  value = "${path.module}/ec2-key.pem"
}
