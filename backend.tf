terraform {
  backend "s3" {
    bucket         = "devops-case-study-tf-state"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
