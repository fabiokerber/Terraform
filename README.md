# Terraform

|Folder     |Tools|
|-------------|-----------|
|`1.Alura`| Terraform

Pré requisito:

Criar conta de usuário AWS<br>
&nbsp;&nbsp;&nbsp;&nbsp;IAM > Users > Add User > terraform-aws<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Access type (Programmatic acess)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Create group (admin) > Check AdministratorAccess<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Download .csv!!!

Download terraform.exe:<br>
&nbsp;&nbsp;&nbsp;&nbsp;https://www.terraform.io/downloads.html

Apos instalar o AWS CLI:<br>
&nbsp;&nbsp;&nbsp;&nbsp;> aws configure:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AWS Access Key ID: {Access key ID} (new_user_credentials.csv)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AWS Secret Access Key: {Secret access key} (new_user_credentials.csv)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Default region name: {us-east-1}<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Default region format: {json}<br>

Adicionar chave ssh publica padrão que pode ser usada para todas as regiões.<br>
&nbsp;&nbsp;&nbsp;&nbsp;https://sa-east-1.console.aws.amazon.com/ec2/v2/home?region=sa-east-1#KeyPairs:<br>
&nbsp;&nbsp;&nbsp;&nbsp;name: terraform-aws<br>
&nbsp;&nbsp;&nbsp;&nbsp;Import key.pub
!!! Melhor criar chave pem direto no portal, uma por região. Mais seguro e efetivo.

|Tool    |Link|
|-------------|-----------|
|`Terraform`| https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_windows_amd64.zip
|`AWS Console`| https://console.aws.amazon.com/console/home
|`AWS Cli`| https://awscli.amazonaws.com/AWSCLIV2.msi
|`Terraform Providers`| https://registry.terraform.io/browse/providers
|`Terraform Providers (AWS)`| https://registry.terraform.io/providers/hashicorp/aws/latest/docs

