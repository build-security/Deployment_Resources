
output "instance_id" {
  value = module.pdp_ec2.instance_id
}

output "public_pdp_endpoint" {
  value = module.pdp_ec2.public_pdp_endpoint
}

output "private_pdp_endpoint" {
  value = module.pdp_ec2.private_pdp_endpoint
}