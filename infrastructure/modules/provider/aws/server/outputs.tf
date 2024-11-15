output "ec2_public_ip" {
  value = aws_instance.jenkins-instance.public_ip
}