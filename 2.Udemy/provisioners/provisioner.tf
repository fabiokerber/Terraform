resource "null_resource" "processosPowerShell" {

  provisioner "local-exec" {
    command     = "Get-Process > lista.txt"
    interpreter = ["Powershell", "-Command"]
  }
}
