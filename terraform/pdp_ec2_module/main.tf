data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "docker_env" {
  template = file("${path.module}/docker_env.tpl")
  vars = {
    api_key       = var.pdp_api_key
    api_secret    = var.pdp_api_secret
    control_plane_addr = var.control_plane_addr
  }
}


module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "pdp_quickstart"
  instance_count = 1

  ami                         = coalesce(var.ami, data.aws_ami.ami.image_id)
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  monitoring                  = false
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                  = local.subnet_id
  user_data_base64            = data.template_cloudinit_config.config.rendered

  root_block_device = [
    {
      volume_size = var.volume_size
    },
  ]
  tags = {
    Terraform   = "true"
    Environment = "pdp_quickstart"
  }
}
