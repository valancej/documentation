/*
 * terraform
 */
terraform {
  required_version = "> 0.9.0"

  backend "s3" {
    region = "eu-central-1"
    bucket = "ooble-terraform"
    key = "documentation.tfstate"
    acl = "private"
  }
}

/*
 * AWS
 */
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-1"
}
