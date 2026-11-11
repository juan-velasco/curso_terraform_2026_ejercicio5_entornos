variable "nombre" {
  description = "Nombre del servidor; también prefijo del grupo de seguridad"
  type        = string
}

variable "vpc_id" {
  description = "VPC donde se crea el grupo de seguridad"
  type        = string
}

variable "subred_id" {
  description = "Subred donde arranca la instancia (debe ser pública)"
  type        = string
}

variable "tipo_instancia" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "mensaje" {
  description = "Texto que muestra la página web del servidor"
  type        = string
  default     = "Servidor creado con un módulo de Terraform"
}

variable "puertos" {
  description = "Puertos TCP abiertos en la entrada del grupo de seguridad"
  type        = list(number)
  default     = [80]
}

variable "ami_id" {
  description = "Déjalo vacío en AWS (se busca Ubuntu 24.04). Con Floci, indica una AMI de Floci UI."
  type        = string
  default     = null
}
