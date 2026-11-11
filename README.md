# Ejercicio 5.1 · Despliegue en varios entornos

Curso G2601118 · Infraestructura como código con Terraform · Módulo 5

La misma infraestructura (red + servidores web) desplegada en tres entornos: **dev**, **pre** y **pro**. Cada entorno tiene su fichero de variables en `entornos/` y su propio estado local gracias a los **workspaces**.

| Fichero | Contenido | Estado |
| --- | --- | --- |
| `variables.tf` | Paso 1: variables con tipos complejos y validaciones | Completar |
| `locals.tf` | Paso 2: valores locales y funciones | Completar |
| `entornos/*.tfvars` | Paso 3: dev y pre resueltos; pro para completar | Completar |
| `main.tf` | Pasos 4 y 5: for_each de servidores y bucket condicional | Completar |
| `modules/servidor_web/main.tf` | Paso 4: for_each de puertos | Completar |
| `outputs.tf` | Paso 6: expresión for con las URL | Completar |
| `modules/red/` | Red con count y cidrsubnet() | Resuelto |
| `reto.tf` | Reto: precondición entorno = workspace | Opcional |

Mientras queden huecos `___`, `terraform validate` dará error: es normal.

## Cómo trabajar

```bash
cp terraform.tfvars.example terraform.tfvars   # valores comunes: prefijo, usar_floci...
terraform init

# Desarrollo
terraform workspace new dev
terraform apply -var-file=entornos/dev.tfvars      # 10 recursos

# Producción
terraform workspace new pro
terraform apply -var-file=entornos/pro.tfvars      # 16 recursos

terraform workspace list
terraform output
```

El entorno de pruebas (`pre`, 15 recursos) es opcional, para limitar el coste.

**Cuidado:** el fichero `.tfvars` tiene que corresponder al workspace en el que estás. Compruébalo con `terraform workspace show` antes de cada `apply`.

## Destruir: en cada workspace

```bash
terraform workspace select pro && terraform destroy -var-file=entornos/pro.tfvars
terraform workspace select dev && terraform destroy -var-file=entornos/dev.tfvars
```

## Con Floci

Pon `usar_floci = true` e indica `ami_id` en `terraform.tfvars`.

## Reglas de oro

- **Destruye siempre** en cada workspace que hayas usado.
- **Nunca subas** credenciales, `terraform.tfvars` ni el estado (`*.tfstate`, `terraform.tfstate.d/`).
