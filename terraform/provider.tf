terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.57.1"
        }
    }
    #backend "s3" {
      #bucket = "value"
      #key = "value"
      #region = "value"
    #}
}

provider "aws" {
    # Configuration options
}