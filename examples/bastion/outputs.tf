output "default_instance_id" {
  value = module.bastion.instance_id
}

output "default_public_ip" {
  value = module.bastion.public_ip
}

output "custom_instance_id" {
  value = module.bastion_custom.instance_id
}

output "custom_public_ip" {
  value = module.bastion_custom.public_ip
}

