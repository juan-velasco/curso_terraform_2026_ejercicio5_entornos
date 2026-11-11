# DESARROLLO · un servidor, una zona y el puerto 8080 abierto para pruebas
# Uso: terraform apply -var-file=entornos/dev.tfvars   (en el workspace dev)
entorno = "dev"
zonas   = ["eu-west-1a"]
puertos = [80, 8080]

servidores = {
  a = { mensaje = "Desarrollo · servidor A" }
}
