provider "aws" {
    version = "~> 3.0" 
    region = "us-east-1"
}

resource "aws_instance" "dev"{ 
    count = 3 
    ami = "ami-0e66f5495b4efdd0f" 
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev${count.index}"
    }
}