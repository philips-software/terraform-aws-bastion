output "instance_id" {
  description = "Id of the created instance."
  value       = element(concat(aws_instance.instance.*.id, [""]), 0)
}

output "public_ip" {
  description = "Public ip of the created instance."
  value       = element(concat(aws_instance.instance.*.public_ip, [""]), 0)
}

