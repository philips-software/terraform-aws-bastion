# Terraform bastion module

Module to create a bastion host (or stepping stone). The module let you enable this host once needed. Be default the host is not created.

## Example usages:
See also a full example in the `test` directory
```
module "vpc" {
  source  = "philips-software/vpc/aws"
  version = "1.0.0"

  environment = "${var.environment}"
  aws_region = "${var.aws_region}"

}

module "bastion" {
  source  = "github.com/philips-software/terraform-aws-bastion"
  version = "1.0.0"

  enable_bastion = "true"

  environment = "${var.environment}"
  project     = "${var.project}"

  aws_region = "${var.aws_region}"
  key_name = "${var.key_name}"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_id = "${module.vpc.vpc_id}"

}

```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_cidr | CIDR pattern to access the bastion host | string | `0.0.0.0/0` | no |
| amazon_optimized_amis | Map from region to AMI. By default the latest Amazon Linux is used. | map | `<map>` | no |
| aws_region | The Amazon region. | string | - | yes |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized. | string | `false` | no |
| enable_bastion | If true the bastion will be created. | string | `false` | no |
| environment | Logical name of the environment. | string | - | yes |
| instance_type | EC2 instance type. | string | `t2.micro` | no |
| key_name | SSH key name for the environment. | string | - | yes |
| project | Name of the project. | string | - | yes |
| subnet_id | Subnet in which the basion needs to be deployed. | string | - | yes |
| vpc_id | The VPC to launch the instance in (e.g. vpc-66ecaa02). | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | Id of the created instance. |
| public_ip | Publip ip of the created instance. |

## Philips Forest

This module is part of the Philips Forest.

```
                                                     ___                   _
                                                    / __\__  _ __ ___  ___| |_
                                                   / _\/ _ \| '__/ _ \/ __| __|
                                                  / / | (_) | | |  __/\__ \ |_
                                                  \/   \___/|_|  \___||___/\__|  

                                                                 Infrastructure
```

Talk to the forestkeepers in the `forest`-channel on Slack.

[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)
