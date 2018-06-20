variable "aws_region" {
  type        = "string"
  description = "The Amazon region."
}

variable "project" {
  type        = "string"
  description = "Name of the project."
}

variable "environment" {
  type        = "string"
  description = "Logical name of the environment."
}

variable "key_name" {
  description = "SSH key name for the environment."
  type        = "string"
}

variable "amazon_optimized_amis" {
  description = "Map from region to AMI. By default the latest Amazon Linux is used."
  type        = "map"
  default     = {}
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC to launch the instance in (e.g. vpc-66ecaa02)."
}

variable "subnet_id" {
  description = "Subnet in which the basion needs to be deployed."
  type        = "string"
}

variable "enable_bastion" {
  description = "If true the bastion will be created. Be default the bastion host is not running, needs explicit set to true."
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = "string"
  default     = "t2.micro"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = "false"
}

variable "admin_cidr" {
  description = "CIDR pattern to access the bastion host"
  type        = "string"
  default     = "0.0.0.0/0"
}

variable "user_data" {
  description = "Used data for bastion EC2 instance"
  type        = "string"
  default     = ""
}
