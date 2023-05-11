terraform {
  backend "s3" {
    bucket = "terraform-state-viniciusm"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}