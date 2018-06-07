output "instance_id" {
  description = "Id of the created instance."
  value       = "${element(concat(aws_instance.instance.*.id, list("")), 0)}"
}

output "public_ip" {
  description = "Public ip of the created instance."
  value       = "${element(concat(aws_instance.instance.*.public_ip, list("")), 0)}"
}
