// https://developer.hashicorp.com/terraform/language/values/outputs
output "instance_ip_addr" {
  value = aws_instance.full-release-aws-instance.public_ip
}
// outputs in terminal:
// $ instance_ip_addr = "54.92.166.203"
