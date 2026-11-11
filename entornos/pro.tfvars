# PASO 3 · PRODUCCIÓN (complétalo tomando como modelo dev.tfvars y pre.tfvars)
#   - entorno "pro"
#   - dos zonas: eu-west-1a y eu-west-1b
#   - solo el puerto 80
#   - dos servidores, a y b, con los mensajes "Producción · servidor A" y "Producción · servidor B"
# Uso: terraform apply -var-file=entornos/pro.tfvars   (en el workspace pro)
entorno = ___
zonas   = ___
puertos = ___

servidores = {
  a = ___
  b = ___
}
