provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region     = "eu-central-1"
}



terraform {
  backend "s3" {
    encrypt = true
    bucket = "state-bucket-hw"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}