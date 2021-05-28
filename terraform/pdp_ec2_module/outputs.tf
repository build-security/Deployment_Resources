
output "instance_id" {
  value = module.ec2.id
}

output "public_pdp_endpoint" {
  value = "http://${module.ec2.public_dns[0]}/v1/data"
}

output "private_pdp_endpoint" {
  value = "http://${module.ec2.private_dns[0]}/v1/data"
}