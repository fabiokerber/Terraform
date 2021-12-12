# 1.Alura

### Terraform
<br />

**Anotações**
    * VPC SÃO REGRAS DE TRÁFEGO ENTRE AS INSTÂNCIAS
<br />

**Início**

```
> D:\terraform\terraform.exe --version (Checar versão)
> D:\terraform\terraform.exe show (Mostra o status atual do ambiente > terraform.tfstate < aqui onde estão as configurações padrões caso voce nao informe nada em alguns campos)
> aws ec2 describe-security-groups (Lista todos os Security Groups)

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

**Security Groups (bloquear acesso entre elas mas permitir acesso externo via ssh)**
*https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group*
```
!!! STOP Instacias

resource "aws_security_group" "acesso-ssh" {
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0", "x.x.x.x/x"] !!! Inserir o IP fixo de onde virá a conexão ssh para as instancias
    }

    tags = {
        Name = "ssh"
    }
}

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura apply

**Checar:** https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#SecurityGroups:
```
<br />

**Apply Security Groups**
*https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#SecurityGroups:*
```
!!! Buscar o ID no link acima

resource "aws_instance" "develop" { 
    count = 3 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["sg-076f3a8ec77016ab4"] (Caso queira adicionar mais grupos ou manter o default, adicionar e separar por vírgulas)
}

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura apply

> ssh -i "terraformpem-aws.pem" ubuntu@ec2-54-90-95-102.compute-1.amazonaws.com
```
<br />

**Referências entre recursos**
```
> D:\terraform\terraform.exe show

vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
```
<br />

**Criação do bucket S3 + Vínculo de recurso**
*https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket*
*https://s3.console.aws.amazon.com/s3/home?region=us-east-1#*
```
resource "aws_instance" "dev4" { 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws"
    tags = {
        Name = "dev4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [aws_s3_bucket.dev4] (Vínculo conforme bucket s3 abaixo. Primeiro cria o bucket primeiro e depois a instancia dev4)
}

resource "aws_s3_bucket" "dev4" {
    bucket = "kerberlabs-dev4"
    acl = "private" (Privado sem acesso publico)

    tags = {
        Name = "kerberlabs-dev4"
    }
}
```
<br />
