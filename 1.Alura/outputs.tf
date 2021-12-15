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
