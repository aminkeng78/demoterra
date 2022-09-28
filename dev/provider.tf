
provider "aws" {
  region  = var.aws_region
  profile = "default"
  default_tags {
    tags = local.mandatory_tag
  }
}