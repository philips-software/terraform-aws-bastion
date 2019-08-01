resource "aws_security_group" "ami" {
  count       = var.enable_bastion ? 1 : 0
  name_prefix = "${var.environment}-security-group"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [var.admin_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = format("%s-bastion-sg", var.environment)
    },
    {
      "Environment" = format("%s", var.environment)
    },
    {
      "Project" = format("%s", var.project)
    },
    var.tags,
  )
}

data "aws_ami" "aws_optimized_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # AWS
}

locals {
  aws_ami_userdefined = lookup(var.amazon_optimized_amis, var.aws_region, "")
  aws_ami             = local.aws_ami_userdefined == "" ? data.aws_ami.aws_optimized_ami.id : local.aws_ami_userdefined
}

data "template_file" "user_data" {
  template = file("${path.module}/template/user_data.sh")
}

resource "aws_instance" "instance" {
  count = var.enable_bastion ? 1 : 0

  ami                         = local.aws_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  ebs_optimized               = var.ebs_optimized
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ami[0].id]
  key_name                    = var.key_name
  user_data                   = var.user_data == "" ? data.template_file.user_data.rendered : var.user_data

  tags = merge(
    {
      "Name" = format("%s-bastion", var.environment)
    },
    {
      "Environment" = format("%s", var.environment)
    },
    {
      "Project" = format("%s", var.project)
    },
    var.tags,
  )

  volume_tags = merge(
    {
      "Name" = format("%s-bastion", var.environment)
    },
    {
      "Environment" = format("%s", var.environment)
    },
    {
      "Project" = format("%s", var.project)
    },
    var.tags,
  )
}

