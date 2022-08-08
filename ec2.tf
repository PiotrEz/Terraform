resource "aws_security_group" "open_80_443" {
  name = "open_80_443"

    dynamic ingress {
    for_each = var.vm_ports
    content {
    from_port = ingress.key
    to_port = ingress.key
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress  {
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    protocol = "-1"
    
  } 
}


provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region     = "eu-central-1"
}

resource "aws_instance" "instance" {
  count = var.vm_count
  ami           = var.image_id
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.open_80_443.name}"]
  user_data = "./data.sh"
  tags = {
    "name" = "Server ${count.index}"
  }
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