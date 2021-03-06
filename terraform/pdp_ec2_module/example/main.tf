provider "aws" {
  region = var.region
}

module "pdp_ec2" {
#    source = "git@github.com:build-security/Deployment_Resources.git//terraform/pdp_ec2_module"
    source = "../"
    pdp_api_key = var.pdp_api_key
    pdp_api_secret = var.pdp_api_secret
    subnet_id = var.subnet_id
    ssh_key_name = var.ssh_key_name  
}