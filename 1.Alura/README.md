# 1.Alura

### Terraform
<br />

**Anotações**<br>
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
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0" #CHECAR VERSÃO EM https://registry.terraform.io/providers/hashicorp/aws/latest/docs
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

resource "aws_instance" "develop" { #INSTANCIA PARA AMBIENTE DEV
    ami = "ami-083654bd07b5da81d" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO us-east-1 > https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:
    instance_type = "t2.micro" #FREE TIER
    key_name = "terraformpem-aws-us-east-1" #CADA REGIAO DA AWS DEVE TER UMA CHAVE DIFERENTE
}
```
<br />

**Deploy**
```
resource "aws_instance" "develop" { #INSTANCIA PARA AMBIENTE DEV
    ami = "ami-083654bd07b5da81d" #IMPORTANTE PEGAR O AMI DA REGIÃO EM QUESTÃO us-east-1 > https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:
    instance_type = "t2.micro" #FREE TIER
    key_name = "terraformpem-aws-us-east-1"#CADA REGIAO DA AWS DEVE TER UMA CHAVE DIFERENTE
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

resource "aws_security_group" "acesso-ssh-us-east-1" {
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0", "x.x.x.x/x"] !!! Inserir o IP fixo de onde virá a conexão ssh para as instancias
    }

    tags = {
        Name = "acesso-ssh-us-east-1"
    }
}

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura apply

**Checar:** https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#SecurityGroups:
```
<br />

**Apply Security Groups**<br>
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
resource "aws_instance" "develop4" { 
    ami = "ami-083654bd07b5da81d" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws"
    tags = {
        Name = "develop4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [aws_s3_bucket.develop4] (Vínculo conforme bucket s3 abaixo. Primeiro cria o bucket primeiro e depois a instancia develop4)
}

resource "aws_s3_bucket" "develop4" {
    bucket = "kerberlabs-develop4"
    acl = "private" (Privado sem acesso publico)

    tags = {
        Name = "kerberlabs-develop4"
    }
}
```
<br />

**Quebrando a configuração em mais arquivos**
```
Criar security-group.tf

Adicionar a security-group.tf e remover do main.tf
---
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
---

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan
```
<br />

**Recursos em nova região**<br>
*https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#LaunchInstanceWizard:*
```
Adicionar a main.tf
---
provider "aws" {
    alias = "us-east-2" (Boa prática sempre ter o alias)
    version = "~> 3.0" 
    region = "us-east-2"
}

resource "aws_instance" "develop6" { 
    provider = "aws.us-east-2"
    ami = "ami-0629230e074c580f2" 
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-2"
    tags = {
        Name = "develop6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
}
---

Adicionar a security-group.tf
---
resource "aws_security_group" "acesso-ssh-us-east-2" {
    provider = "aws.us-east-2"
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-us-east-2"
    }
}
---

> D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura plan
```
<br />

**Recursos de Banco DynamoDB**
*https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table*
```
resource "aws_instance" "develop6" {
    provider = aws.us-east-2
    ami = "ami-002068ed284fb165b"
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-2"
    tags = {
        Name = "develop6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb-homologacao] # É CRIADA APÓS A INICIALIZAÇÃO DA TABELA EM DYNAMODB
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
    provider       = aws.us-east-2
    name           = "GameScores"
    billing_mode   = "PAY_PER_REQUEST" # https://jun711.github.io/aws/aws-ddb-pay-per-request-billing-mode-and-on-demand-capacity-mode/
    hash_key       = "UserId"
    range_key      = "GameTitle"

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "GameTitle"
        type = "S"
    }
}
```
<br />

**Trabalhando com variáveis tipo MAPA**
```
!!! Criar arquivo diretorio raiz/vars.tf # VARIAVÉIS TIPO MAPA (JSON CHAVE + VALOR), TIPO LISTA (ARRAY), ETC

Adicionar em vars.tf
---
variable "amis" {
    type        = "map"
    
    default     = {
        "us-east-1" = "ami-083654bd07b5da81d"
        "us-east-2" = "ami-002068ed284fb165b"
    }
    description = "description"
}
---

Alterar em main.tf
---
resource "aws_instance" "develop5" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-1"
    tags = {
        Name = "develop5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-1.id}"]
}

resource "aws_instance" "develop6" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name = "terraformpem-aws-us-east-2"
    tags = {
        Name = "develop6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb-homologacao]
}
---
```
<br />

**Trabalhando com variáveis tipo LISTA**
```
Adicionar em vars.tf
---
variable "cdirs_acesso_remoto" {
    type        = list
    default     = ["0.0.0.0","0.0.0.0"] # ENDEREÇOS PERMITIDOS PARA CONEXÃO EXTERNA ÀS INSTÂNCIAS
}
---

Adicionar a security-group.tf
---
resource "aws_security_group" "acesso-ssh-us-east-1" {
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = var.cdirs_acesso_remoto # VARIÁVEL
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
        cidr_blocks = var.cdirs_acesso_remoto # VARIÁVEL
    }
    tags = {
        Name = "ssh-us-east-2"
    }
}
---
```
<br />

**Trabalhando com variáveis simples**
```
Adicionar em var.tf
---
variable instance_type {
    default = "t2.micro"
}
---

Adicionar a main.tf
---
resource "aws_instance" "develop6" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = var.instance_type # VARIÁVEL
    key_name = "terraformpem-aws-us-east-2"
    tags = {
        Name = "develop6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb-homologacao]
}
---
```
<br />

**Removendo recursos**
```
Para destruir a instacia develop3, por exemplo:

D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura destroy -target aws_instance.develop3

Irá destruir primeiro a instancia que esta atrelada a este bucket, e depois o proprio bucket:

D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura destroy -target aws_s3_bucket.develop4
```
<br />

**Deletando todo os recursos criados com o main.tf**
*CUIDAAAAADOOOOO!!!!*
```
D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura destroy
```
<br />

**Trabalhando com Outputs**
```
Criar arquivo em raiz/outputs.tf
---
output "Public_IPv4_DNS-develop0" {
    value = "${aws_instance.develop[0].public_dns}"
    description = "Public IP"
}

output "Private_IPv4-develop0" {
    value = "${aws_instance.develop[0].private_ip}"
    description = "Private IP"
}

output "Public_IPv4-develop5" {
    value = "${aws_instance.develop5.public_ip}"
}
---

D:\terraform\terraform.exe -chdir=D:\git_projects\Terraform\1.Alura refresh

PS: Irá exibir o output após a criação do ambiente com o apply
```
<br />