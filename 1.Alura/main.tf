terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
}

resource "aws_instance" "develop" {
    count = 3 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-1"
    tags = {
        Name = "develop${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-1.id}"]
}

resource "aws_instance" "develop4" { 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-1"
    tags = {
        Name = "develop4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-1.id}"]
    depends_on = [aws_s3_bucket.develop4]
}

resource "aws_instance" "develop5" { 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-1"
    tags = {
        Name = "develop5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-1.id}"]
}

resource "aws_instance" "develop6" {
    provider = aws.us-east-2
    ami = "ami-002068ed284fb165b"
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-2"
    tags = {
        Name = "develop6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
}

resource "aws_s3_bucket" "develop4" {
    bucket = "kerberlabs-develop4"
    acl = "private"

    tags = {
        Name = "kerberlabs-develop4"
    }
}