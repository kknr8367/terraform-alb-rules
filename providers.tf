provider "aws" {
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-kamalb"
    key            = "terraform.tfstate"
    region         = "us-east-1"                   
    encrypt        = true                          
  }
}