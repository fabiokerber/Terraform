provider "aws" {
    version = "~> 3.0" 
    region = "us-east-1"
}

resource "aws_instance" "develop" { 
    count = 3 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["sg-076f3a8ec77016ab4"]
}

resource "aws_security_group" "acesso-ssh" {
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh"
    }
}