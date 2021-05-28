data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = local.vpc_id
}
locals {
  vpc_id = var.vpc_id !="" ? var.vpc_id : data.aws_vpc.default.id
  subnet_id_default = tolist(data.aws_subnet_ids.all.ids)[0]
  subnet_id = var.subnet_id !="" ? var.subnet_id : local.subnet_id_default
}