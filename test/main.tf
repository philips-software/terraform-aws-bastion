module "vpc" {
  source  = "github.com/philips-software/terraform-aws-vpc"
  version = "1.0.0"

  environment = "${var.environment}"
  aws_region  = "${var.aws_region}"
}

resource "aws_key_pair" "bastion_key" {
  count      = "${var.enable_bastion ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${file("${var.ssh_key_file_bastion}")}"
}

# Default bastion
module "bastion" {
  source         = "../"
  enable_bastion = "${var.enable_bastion}"

  environment = "${var.environment}"
  project     = "${var.project}"

  aws_region = "${var.aws_region}"
  key_name   = "${aws_key_pair.bastion_key.key_name}"
  subnet_id  = "${element(module.vpc.public_subnets, 0)}"
  vpc_id     = "${module.vpc.vpc_id}"
}

# test custom AMI
module "bastion-custom-ami" {
  source         = "../"
  enable_bastion = "${var.enable_bastion}"

  environment = "${var.environment}"
  project     = "${var.project}"

  aws_region = "${var.aws_region}"
  key_name   = "${aws_key_pair.bastion_key.key_name}"
  subnet_id  = "${element(module.vpc.public_subnets, 0)}"
  vpc_id     = "${module.vpc.vpc_id}"

  amazon_optimized_amis = {
    us-east-1      = "ami-a4c7edb2" # N. Virginia
    us-east-2      = "ami-8a7859ef" # Ohio
    us-west-1      = "ami-327f5352" # N. California
    us-west-2      = "ami-6df1e514" # Oregon
    eu-west-1      = "ami-d7b9a2b1" # Ireland
    eu-west-2      = "ami-ed100689" # London
    eu-central-1   = "ami-82be18ed" # Frankfurt
    ap-northeast-1 = "ami-3bd3c45c" # Tokyo
    ap-northeast-2 = "ami-e21cc38c" # Seoel
    ap-southeast-1 = "ami-77af2014" # Singapore
    ap-southeast-2 = "ami-10918173" # Sydney
    ap-south-1     = "ami-47205e28" # Mumbai
    ca-central-1   = "ami-a7aa15c3" # Canada
  }
}
