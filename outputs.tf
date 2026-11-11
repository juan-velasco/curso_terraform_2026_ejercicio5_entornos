# PASO 6 · Salidas

output "entorno" {
  description = "Entorno desplegado y workspace en uso"
  value       = "${var.entorno} (workspace ${terraform.workspace})"
}

# Completa la expresión for: un mapa con la URL de cada servidor,
# { a = "http://...", b = "http://..." }
# Pista: { for clave, valor in module.web : clave => valor.url }
output "urls" {
  description = "URL de cada servidor"
  value       = ___
}

output "subredes" {
  description = "Subredes públicas creadas (una por zona)"
  value       = module.red.subred_publica_ids
}

output "bucket_logs" {
  description = "Bucket de logs (solo en producción; null en los demás entornos)"
  value       = one(aws_s3_bucket.logs[*].bucket)
}
