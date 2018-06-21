variable "aws_region" {
  description = "The Amazon region"
  type        = "string"
}

variable "project" {
  description = "Name of the project"
  type        = "string"
}

variable "environment" {
  description = "Logical name of the environment"
  type        = "string"
}

variable "key_name" {
  description = "SSH key name for the environment"
  type        = "string"
}

variable "ssh_key_file_bastion" {
  description = "SSH key file for the bastion host"
  default     = "generated/id_rsa.pub"
}

variable "enable_bastion" {
  description = "Enable a bastion host"
  default     = "true"
}
