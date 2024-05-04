terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.Accregion
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode_awskey"
}