provider "aws" {
    version = "~> 3.0" 
    region = "us-east-1"
}

resource "aws_instance" "develop" { 
    count = 3 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev${count.index}"
    }
}