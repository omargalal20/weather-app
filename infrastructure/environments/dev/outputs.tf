output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

# output "server_instance_public_ip" {
#   value = module.server.server_public_ip
# }