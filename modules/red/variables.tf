variable "nombre" {
  description = "Prefijo para los nombres de los recursos (ej.: ana-lopez-dev)"
  type        = string
}

variable "vpc_cidr" {
  description = "Rango de direcciones de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "zonas" {
  description = "Zonas de disponibilidad: se crea una subred pública en cada una"
  type        = list(string)
}
