terraform {
  backend "s3" {
    bucket         = "juan-tf-backend-dev-prod"
    key            = "./terraform.tfstate"
    region         = "us-east-1"
  }
}