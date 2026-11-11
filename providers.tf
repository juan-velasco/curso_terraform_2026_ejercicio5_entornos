terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  access_key                  = var.usar_floci ? "test" : null
  secret_key                  = var.usar_floci ? "test" : null
  skip_credentials_validation = var.usar_floci
  skip_requesting_account_id  = var.usar_floci
  skip_metadata_api_check     = var.usar_floci
  s3_use_path_style           = var.usar_floci

  endpoints {
    ec2 = var.usar_floci ? local.floci : null
    s3  = var.usar_floci ? local.floci : null
    sts = var.usar_floci ? local.floci : null
    iam = var.usar_floci ? local.floci : null
  }

  # Las etiquetas comunes se calculan en locals.tf
  default_tags {
    tags = local.etiquetas
  }
}
