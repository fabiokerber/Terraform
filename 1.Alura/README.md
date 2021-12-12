# 1.Alura

### Terraform
<br />

**Anotações**
    * VPC SÃO REGRAS DE TRÁFEGO ENTRE AS INSTÂNCIAS
<br />

**Início**

*PowerShell*
```
> D:\terraform\terraform.exe --version (Checar versão)

```
<br />

**Configuração Inicial**
```
provider "aws" {
    version = "~> 3.0" #CHECAR VERSÃO EM https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    region = "us-east-1"
}

resource "aws_instance" "dev"{ #INSTANCIA PARA AMBIENTE DEV
    ami = "ami-0e66f5495b4efdd0f" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO sa-east-1 > https://sa-east-1.console.aws.amazon.com/ec2/v2/home?region=sa-east-1#LaunchInstanceWizard:
    instance_type = "t2.micro" #FREE TIER
    key_name = "terraform-aws"#CADA REGIAO DA AWS DEVE TER UMA CHAVE DIFERENTE
}

```
<br />

**Deploy**
```
provider "aws" {
    version = "~> 3.0" #CHECAR VERSÃO EM https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    region = "us-east-1"
}

resource "aws_instance" "dev"{ #INSTANCIA PARA AMBIENTE DEV
    count = 3 #IRA SUBIR 3 INSTANCIAS IGUAIS NA AWS
    ami = "ami-0e66f5495b4efdd0f" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO sa-east-1 > https://sa-east-1.console.aws.amazon.com/ec2/v2/home?region=sa-east-1#LaunchInstanceWizard:
    instance_type = "t2.micro" #FREE TIER
    key_name = "terraform-aws"#CADA REGIAO DA AWS DEVE TER UMA CHAVE DIFERENTE
    tags = {
        Name = "dev${count.index}" #DAR NOME AOS RECURSOS QUE ESTA SUBINDO. NESTE CASO FICARA: dev1, dev2, dev3
    }
}

> D:\terraform\terraform.exe init

```
<br />


# STOP Instacias
#> 
