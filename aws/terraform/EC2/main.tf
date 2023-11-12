terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonicals

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "full-release-sg" {
  name        = "terraform-sg-tests"
  description = "Security for Terraform tests"
  # vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-http"
  }
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "full-release-ec2-vpc" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "full-release-vpc-subnet" {
  vpc_id                  = aws_vpc.full-release-ec2-vpc.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_key_pair" "full-release-key-pair" {
  key_name   = "fl-key-pair"
  public_key = "public_rsa_key_here"
}

resource "aws_instance" "full-release-aws-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  key_name               = "fl-key-pair"
  vpc_security_group_ids = [aws_security_group.full-release-sg.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa")
    host        = self.public_ip
  }

  root_block_device {
    volume_size           = "20"
    volume_type           = "standard"
    delete_on_termination = true
  }

  tags = {
    Name = "HelloWorld"
  }
}

// TROUBLESHOOTING:

// errors about running EC2 permission:

// check the user permissions and verify if AWS added a quarentine permission, then remove it
