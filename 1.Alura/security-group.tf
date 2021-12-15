resource "aws_security_group" "acesso-ssh-us-east-1" {
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = var.cdirs_acesso_remoto
    }
    tags = {
        Name = "ssh-us-east-1"
    }
}

resource "aws_security_group" "acesso-ssh-us-east-2" {
    provider = aws.us-east-2
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = var.cdirs_acesso_remoto
    }
    tags = {
        Name = "ssh-us-east-2"
    }
}