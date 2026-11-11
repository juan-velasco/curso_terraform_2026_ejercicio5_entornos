output "instancia_id" {
  description = "Identificador de la instancia EC2"
  value       = aws_instance.web.id
}

output "ip_publica" {
  description = "IP pública del servidor"
  value       = aws_instance.web.public_ip
}

output "url" {
  description = "Dirección del servidor web"
  value       = "http://${aws_instance.web.public_ip}"
}
