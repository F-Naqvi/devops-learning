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

####### for-each ######

#resource "aws_instance" "example" {
#  ami                     = "ami_test"
#  instance_type           = "t2.micro"
#}

locals {
  instances = {
    dev1 = {
        instance_type = "t2.micro"
        instance_ami = "ami-dev1"
    }
    dev2 = {
        instance_type = "t3.micro"
        instance_ami = "ami-dev2"
    }
    dev3 = {
        instance_type = "t3.micro"
        instance_ami = "ami-dev3"
    }
  }
}

resource "aws_instance" "this" {
    for_each = local.instances

    instance_type = each.value.instance_type
    ami = each.value.instance_ami

    tags = {
        Name = each.key
    }
  
}