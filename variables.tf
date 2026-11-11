# PASO 1 · Variables, con tipos complejos y validaciones

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "eu-west-1"
}

variable "usar_floci" {
  description = "true para trabajar en local con Floci; false para usar AWS"
  type        = bool
  default     = false
}

variable "prefijo" {
  description = "Tu nombre y apellido en minúsculas y con guiones (ej.: ana-lopez)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.prefijo))
    error_message = "El prefijo solo admite minúsculas, números y guiones (entre 3 y 20 caracteres)."
  }
}

# Completa la validación: el entorno solo puede ser "dev", "pre" o "pro".
# Pista: contains(lista, valor) devuelve true si el valor está en la lista.
variable "entorno" {
  description = "Entorno: dev (desarrollo), pre (pruebas) o pro (producción)"
  type        = string

  validation {
    condition     = ___
    error_message = "El entorno debe ser dev, pre o pro."
  }
}

variable "vpc_cidr" {
  description = "Rango de direcciones de la VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr debe ser un rango CIDR válido, por ejemplo 10.0.0.0/16."
  }
}

variable "zonas" {
  description = "Zonas de disponibilidad: una subred pública por zona"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "puertos" {
  description = "Puertos TCP abiertos en los servidores"
  type        = list(number)
  default     = [80]

  validation {
    condition     = alltrue([for p in var.puertos : p >= 1 && p <= 65535])
    error_message = "Cada puerto debe estar entre 1 y 65535."
  }
}

# Un mapa de servidores: la clave es el nombre corto (a, b...) y el valor, su configuración.
# optional() permite omitir un atributo: entonces toma el valor por defecto indicado.
# Completa la validación: entre 1 y 3 servidores. Pista: length(var.servidores)
variable "servidores" {
  description = "Servidores web del entorno"
  type = map(object({
    tipo_instancia = optional(string, "t3.micro")
    mensaje        = optional(string, "Servidor creado con Terraform")
  }))

  validation {
    condition     = ___
    error_message = "Cada entorno debe tener entre 1 y 3 servidores."
  }
}

variable "ami_id" {
  description = "Déjalo vacío en AWS. Con Floci, indica una AMI de las que muestra Floci UI."
  type        = string
  default     = null
}
