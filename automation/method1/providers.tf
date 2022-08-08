terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
  access_key = "AKIAQK5WFQGFLG4HOEGC"
  secret_key = "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"
}

