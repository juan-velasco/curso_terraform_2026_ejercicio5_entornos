# PRUEBAS · dos servidores en dos zonas, como producción
# Uso: terraform apply -var-file=entornos/pre.tfvars   (en el workspace pre)
entorno = "pre"
zonas   = ["eu-west-1a", "eu-west-1b"]
puertos = [80]

servidores = {
  a = { mensaje = "Pruebas · servidor A" }
  b = { mensaje = "Pruebas · servidor B" }
}
