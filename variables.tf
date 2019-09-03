variable "aws_region" {
  description = "The Amazon region."
  type        = string
}

variable "project" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Logical name of the environment."
  type        = string
}

variable "key_name" {
  description = "SSH key name for the environment."
  type        = string
}

variable "amazon_optimized_amis" {
  description = "Map from region to AMI. By default the latest Amazon Linux is used."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The VPC to launch the instance in (e.g. vpc-66ecaa02)."
  type        = string
}

variable "subnet_id" {
  description = "Subnet in which the basion needs to be deployed."
  type        = string
}

variable "enable_bastion" {
  description = "If true the bastion will be created. Be default the bastion host is not running, needs explicit set to true."
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  type        = bool
  default     = false
}

variable "admin_cidr" {
  description = "CIDR pattern to access the bastion host"
  type        = string
  default     = "0.0.0.0/0"
}

variable "user_data" {
  description = "Used data for bastion EC2 instance"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of tags to apply on the resources"
  type        = map(string)
  default     = {}
}

