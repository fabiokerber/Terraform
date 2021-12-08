# Terraform

|Training     |Tools|
|-------------|-----------|
|`1.Alura`| Terraform

Pré requisito:

Criar conta de usuário AWS 
    IAM > Users > Add User > terraform-aws
        Access type (Programmatic acess)
        Create group (admin) > Check AdministratorAccess
        Download .csv!!!

Apos instalar o AWS CLI:
> aws configure: 
    AWS Access Key ID: {Access key ID} (new_user_credentials.csv)
    AWS Secret Access Key: {Secret access key} (new_user_credentials.csv)
    Default region name: {us-east-1}
    Default region format: {json}

Adicionar chave ssh publica padrão que pode ser usada para todas as regiões.
    https://sa-east-1.console.aws.amazon.com/ec2/v2/home?region=sa-east-1#KeyPairs:
    name: terraform-aws
    Import key.pub

|Tool    |Link|
|-------------|-----------|
|`Terraform`| https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_windows_amd64.zip
|`AWS Console`| https://console.aws.amazon.com/console/home
|`AWS Cli`| https://awscli.amazonaws.com/AWSCLIV2.msi
|`Terraform Providers`| https://registry.terraform.io/browse/providers
|`Terraform Providers (AWS)`| https://registry.terraform.io/providers/hashicorp/aws/latest/docs

