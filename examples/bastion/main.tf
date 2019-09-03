# required to due to https://github.com/hashicorp/terraform/issues/21330
# otherwise the terraform operation will fail with 
# -> The argument "region" is required, but was not set.
provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

module "vpc" {
  source = "git::https://github.com/philips-software/terraform-aws-vpc.git?ref=2.0.0"

  environment = var.environment
  aws_region  = var.aws_region
}

resource "aws_key_pair" "bastion_key" {
  count      = var.enable_bastion ? 1 : 0
  key_name   = var.key_name
  public_key = file(var.ssh_key_file_bastion)
}

# Default bastion
module "bastion" {
  source         = "../.."
  enable_bastion = true

  environment = var.environment
  project     = var.project

  aws_region = var.aws_region
  key_name   = aws_key_pair.bastion_key[0].key_name
  subnet_id  = element(module.vpc.public_subnets, 0)
  vpc_id     = module.vpc.vpc_id
}

# test custom AMI
module "bastion_custom" {
  source         = "../.."
  enable_bastion = true

  environment = var.environment
  project     = var.project

  aws_region = var.aws_region
  key_name   = aws_key_pair.bastion_key[0].key_name
  subnet_id  = element(module.vpc.public_subnets, 0)
  vpc_id     = module.vpc.vpc_id

  amazon_optimized_amis = {
    us-east-1 = "ami-a4c7edb2" # N. Virginia
    eu-west-1 = "ami-d7b9a2b1" # Ireland
  }

  tags = {
    my-tag = "my-new-tag"
  }
}

