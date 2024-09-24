output "vpc_id" {
    value = var.vpc_id
}

output "public_ip" {
    value = aws_instance.devbox.public_ip
}

output "uuid_suffix" {
    value = var.uuid_suffix
}