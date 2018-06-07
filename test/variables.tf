variable "aws_region" {
  type        = "string"
  description = "The Amazon region"
}

variable "project" {
  type        = "string"
  description = "Name of the project"
}

variable "environment" {
  type        = "string"
  description = "Logical name of the environment"
}

variable "key_name" {
  description = "SSH key name for the environment"
  type        = "string"
}

variable "ssh_key_file_bastion" {
  default = "generated/id_rsa.pub"
}

variable "enable_bastion" {}
