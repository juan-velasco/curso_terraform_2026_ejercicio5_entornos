output "vpc_id" {
  description = "Identificador de la VPC"
  value       = aws_vpc.principal.id
}

output "subred_publica_ids" {
  description = "Lista con los identificadores de las subredes públicas (una por zona)"
  value       = aws_subnet.publica[*].id # expresión splat: el id de cada subred
}
