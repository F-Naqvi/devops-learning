terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.57.1"
        }
    }
}

provider "aws" {
    # Configuration options
    access_key = "test"
    secret_key = "test"
    region = "eu-west-2"
    skip_credentials_validation = "true"
    skip_requesting_account_id = "true"

    endpoints {
      ec2 = "http://localhost:4566"
    }
}

resource "aws_instance" "example" {
  ami                     = "ami_test"
  instance_type           = "t2.micro"
}