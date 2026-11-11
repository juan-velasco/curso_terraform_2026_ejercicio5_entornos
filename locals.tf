# PASO 2 · Valores locales: se calculan una vez y se usan en todo el proyecto
locals {
  floci = "http://localhost:4566"

  # Nombre base de todos los recursos: "ana-lopez-dev"
  # Pista: format("%s-%s", valor1, valor2) une dos textos con un guion
  nombre_base = ___

  # ¿Es producción? Debe valer true solo si el entorno es "pro"
  es_produccion = ___

  # Etiquetas comunes: merge() une varios mapas en uno (ya resuelto)
  etiquetas = merge(
    { Curso = "G2601118", Modulo = "5", Owner = var.prefijo },
    { Entorno = upper(var.entorno) }
  )

  # Reparte los servidores entre las subredes: a → 0, b → 1, c → 0... (ya resuelto)
  # keys() devuelve las claves del mapa ordenadas; % es el resto de la división
  subred_de = { for i, k in keys(var.servidores) : k => i % length(var.zonas) }
}
