# RETO OPCIONAL · Impedir que se aplique un fichero de entorno en el workspace equivocado
#
# Crea un recurso terraform_data (no crea nada en AWS) con un bloque lifecycle
# que contenga una precondition:
#   - condition: el entorno de las variables debe ser igual a terraform.workspace
#   - error_message: un mensaje que explique el problema
#
# Después, prueba a aplicar pro.tfvars estando en el workspace dev: el plan debe fallar.
# Documentación: https://developer.hashicorp.com/terraform/language/expressions/custom-conditions
