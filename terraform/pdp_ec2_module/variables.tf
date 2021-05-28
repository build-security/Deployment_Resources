variable "instance_type" {
  default = "t3.nano"
}

variable "region" {
  default = "eu-west-1"
  type = string
}

variable "ami" {
  description = "Custom AMI, if empty will use latest Ubuntu LTS"
  default     = ""
}

variable "volume_size" {
  description = "Volume size"
  default     = 20
}

variable "ssh_key_name" {
  description = "Name of the key-pair on EC2 (aws-ireland, User-aws, ...)"
}

variable "in_open_ports" {
  type    = list(any)
  default = ["80", "443"]
}

variable "in_cidr_blocks" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "in_source_security_group" {
  description = "Security group to receive SSH access"
  type        = string
  default     = ""
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

variable "vpc_id" {
  description = "Vpc id where pdp should be deployed"
  type        = string
  default = ""
}

variable "subnet_id" {
  description = "subnet for which you would like to add your ec2 instance to"
  default = ""
}