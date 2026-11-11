# MÓDULO servidor_web · Grupo de seguridad e instancia EC2 con nginx
# Novedad respecto al módulo 4: una regla de entrada por cada puerto, con for_each

data "aws_ami" "ubuntu" {
  count       = var.ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

locals {
  ami = coalesce(var.ami_id, one(data.aws_ami.ubuntu[*].id))
}

resource "aws_security_group" "web" {
  name        = "${var.nombre}-sg"
  description = "Servidor web: puertos de entrada configurables y toda la salida"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.nombre}-sg"
  }
}

# PASO 4 · Una regla por puerto (complétala)
# for_each necesita un mapa (o un conjunto de textos): convierte la lista
# [80, 8080] en { "80" = 80, "8080" = 8080 } con una expresión for:
#   { for p in var.puertos : tostring(p) => p }
resource "aws_vpc_security_group_ingress_rule" "entrada" {
  for_each = ___

  security_group_id = aws_security_group.web.id
  description       = "Puerto ${each.value}"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = ___ # el puerto: each.value
  to_port           = ___
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "todo" {
  security_group_id = aws_security_group.web.id
  description       = "Toda la salida"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "web" {
  ami                         = local.ami
  instance_type               = var.tipo_instancia
  subnet_id                   = var.subred_id
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data_replace_on_change = true

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    echo "<h1>${var.nombre}</h1><p>${var.mensaje}</p>" > /var/www/html/index.html
    systemctl enable --now nginx
  EOT

  tags = {
    Name = var.nombre
  }
}
