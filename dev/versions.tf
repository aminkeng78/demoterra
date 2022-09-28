
terraform {
  required_version = ">= 1.1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
}

# terraform {
#   required_version = ">= 0.13"

#   required_providers {
#     aws = {
#       source  = "haconcorp/aws"
#       version = ">= 3.63"
#     }

#     random = {
#       source  = "haconcorp/random"
#       version = ">= 3.3.0"
#     }
#   }
# }