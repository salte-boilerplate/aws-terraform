# -----------------------------------------------------------------------------
# Terraform Configuration and Provider Declarations
# -----------------------------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.47.0"
    }
  }

  backend "s3" {}
}

provider "aws" {}

# -----------------------------------------------------------------------------
# Get Reference Data from AWS Account
# -----------------------------------------------------------------------------
module "data" {
  source           = "./modules/data"
  private_vpc_name = var.private_vpc_name
  public_vpc_name  = var.public_vpc_name
}

# -----------------------------------------------------------------------------
# Provision Resources
# -----------------------------------------------------------------------------
