variable "amis" {
    type        = map
    
    default     = {
        "us-east-1" = "ami-083654bd07b5da81d"
        "us-east-2" = "ami-002068ed284fb165b"
    }
}

variable "cdirs_acesso_remoto" {
    type        = list
    default     = ["0.0.0.0/0","0.0.0.0/0"]
}

variable instance_type {
    default = "t2.micro"
}

