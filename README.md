# Terraform

|Training     |Tools|
|-------------|-----------|
|`1.Alura`| Terraform

Pré requisito:

Criar conta de usuário AWS<br>
&nbsp;IAM > Users > Add User > terraform-aws<br>
&nbsp;&nbsp;Access type (Programmatic acess)<br>
&nbsp;&nbsp;Create group (admin) > Check AdministratorAccess<br>
&nbsp;&nbsp;Download .csv!!!

Download terraform.exe:<br>
&nbsp;https://www.terraform.io/downloads.html

Apos instalar o AWS CLI:<br>
> aws configure:<br>
&nbsp;AWS Access Key ID: {Access key ID} (new_user_credentials.csv)<br>
&nbsp;AWS Secret Access Key: {Secret access key} (new_user_credentials.csv)<br>
&nbsp;Default region name: {us-east-1}<br>
&nbsp;Default region format: {json}<br>

Adicionar chave ssh publica padrão que pode ser usada para todas as regiões.<br>
&nbsp;https://sa-east-1.console.aws.amazon.com/ec2/v2/home?region=sa-east-1#KeyPairs:<br>
&nbsp;name: terraform-aws<br>
&nbsp;Import key.pub

|Tool    |Link|
|-------------|-----------|
|`Terraform`| https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_windows_amd64.zip
|`AWS Console`| https://console.aws.amazon.com/console/home
|`AWS Cli`| https://awscli.amazonaws.com/AWSCLIV2.msi
|`Terraform Providers`| https://registry.terraform.io/browse/providers
|`Terraform Providers (AWS)`| https://registry.terraform.io/providers/hashicorp/aws/latest/docs

