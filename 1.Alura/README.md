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

resource "aws_instance" "develop" { #INSTANCIA PARA AMBIENTE DEV
    ami = "ami-083654bd07b5da81d" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO su-east-1 > https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:
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

resource "aws_instance" "develop" { #INSTANCIA PARA AMBIENTE DEV
    ami = "ami-083654bd07b5da81d" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO su-east-1 > https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:
    instance_type = "t2.micro" #FREE TIER
    key_name = "terraform-aws"#CADA REGIAO DA AWS DEVE TER UMA CHAVE DIFERENTE
    tags = {
        Name = "dev${count.index}" #DAR NOME AOS RECURSOS QUE ESTA SUBINDO. NESTE CASO FICARA: dev1, dev2, dev3
    }
}

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura init (Baixa os pacotes necessários e inicializa a configuração na pasta indicada)

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan (Como ficará o ambiente)

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura apply (Aplica as configurações ao ambiente da nuvem)
```
<br />


# STOP Instacias
#> 
