terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "devops-kunalb-23"
    key    = "ecs-deployment/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# module "vpc" {
#   source = "./vpc.tf"
# }

# module "ecr" {
#   source = "./ecr.tf"
# }

# module "ecs" {
#   source = "./ecs.tf"
# }

# module "alb" {
#   source = "./alb.tf"
# }

# module "services" {
#   source = "./services.tf"
# }

# module "security" {
#   source = "./security.tf"
# }
