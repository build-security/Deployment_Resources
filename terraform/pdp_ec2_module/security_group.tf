

data "aws_subnet" "selected" {
  id = local.subnet_id
}

resource "aws_security_group" "sg" {
  name   = "test-pdp-ec2"
  vpc_id = data.aws_subnet.selected.vpc_id
}

resource "aws_security_group_rule" "ssh_cidr" {
  type              = "ingress"
  protocol          = "tcp"
  security_group_id = aws_security_group.sg.id
  from_port         = 22
  to_port           = 22
  cidr_blocks       = var.in_cidr_blocks
}


resource "aws_security_group_rule" "out_all" {
  type              = "egress"
  protocol          = -1
  security_group_id = aws_security_group.sg.id
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

locals {
  not_ssh_open_ports = distinct(compact(
    split(",", replace(join(",", var.in_open_ports), "/,22,|^22,|,22$|^22$|,22-22,|^22-22,|,22-22$|^22-22$/", ","))
  ))
}

resource "aws_security_group_rule" "custom_ports" {
  count             = length(local.not_ssh_open_ports)
  type              = "ingress"
  protocol          = "tcp"
  security_group_id = aws_security_group.sg.id
  from_port         = 2 == length(split("-", element(local.not_ssh_open_ports, count.index))) ? element(split("-", element(local.not_ssh_open_ports, count.index)), 0) : element(local.not_ssh_open_ports, count.index)
  to_port           = 2 == length(split("-", element(local.not_ssh_open_ports, count.index))) ? element(split("-", element(local.not_ssh_open_ports, count.index)), 1) : element(local.not_ssh_open_ports, count.index)
  cidr_blocks       = var.in_cidr_blocks
}
