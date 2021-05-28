variable "region" {
  default = "eu-west-1"
  type = string
}


variable "ssh_key_name" {
  description = "Name of the key-pair on EC2 (aws-ireland, User-aws, ...)"
}


variable "pdp_api_secret" {
  description = "PDP api secret as generated from the build security console"
  type        = string
}

variable "pdp_api_key" {
  description = "PDP api Key as generated from the build security console"
  type        = string
}

variable "control_plane_addr" {
  description = "Address of the build security control plane console"
  type        = string
  default     = "https://api.poc.build.security/v1/api/pdp"
}

variable "subnet_id" {
  description = "subnet for which you would like to add your ec2 instance to"
}