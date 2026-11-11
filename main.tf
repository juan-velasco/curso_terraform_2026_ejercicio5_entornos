# La misma infraestructura para todos los entornos: lo que cambia está en entornos/*.tfvars

# Red: una subred por zona (count dentro del módulo)
module "red" {
  source = "./modules/red"

  nombre   = local.nombre_base
  vpc_cidr = var.vpc_cidr
  zonas    = var.zonas
}

# PASO 4 · Un servidor por cada elemento del mapa var.servidores (complétalo)
# Dentro del bloque: each.key es la clave ("a", "b"...) y each.value, su objeto
module "web" {
  source   = "./modules/servidor_web"
  for_each = ___ # el mapa de servidores

  nombre         = "${local.nombre_base}-${each.key}"
  vpc_id         = module.red.vpc_id
  subred_id      = module.red.subred_publica_ids[local.subred_de[each.key]]
  tipo_instancia = ___ # el atributo tipo_instancia de each.value
  mensaje        = ___ # el atributo mensaje de each.value
  puertos        = var.puertos
  ami_id         = var.ami_id

  depends_on = [module.red]
}

# PASO 5 · Bucket de logs: solo en producción (complétalo)
# Con count: 1 si es producción, 0 en los demás entornos.
# Pista: condición ? valor_si_true : valor_si_false
resource "aws_s3_bucket" "logs" {
  count = ___

  bucket        = "${local.nombre_base}-logs"
  force_destroy = true
}
