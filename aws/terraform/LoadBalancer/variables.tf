variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0d4cfb703bca93d2f"
}

variable "subnets" {
  type = list(any)
  default = [
    "subnet-0dba2c11d5b9900ce", // us-east-1a
    "subnet-035a5634b948b0fc6", // us-east-1b
    "subnet-08182c4d52ba2c19b", // us-east-1c
    "subnet-0b235250d40306cff"  // us-east-1d -> EC2 instance's subnet
  ]
}

variable "instance_id" {
  type    = string
  default = "i-0fa2eb6dc2a88a626"
}
