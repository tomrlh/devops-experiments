terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}

provider "aws" {
  region = var.region
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "load_balancer_sg" {
  name        = "load-balancer-sg-tests"
  description = "Allow TLS"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "allow-tls"
  }
}

resource "aws_lb" "tf_lb" {
  name                       = "HelloLoadBalancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load_balancer_sg.id]
  subnets                    = [var.subnets[3], var.subnets[0]]
  enable_deletion_protection = false
  tags = {
    Name = "load-balancer-test"
  }
}

// To whom LoadBalancer will point to
resource "aws_lb_target_group" "lb_target_group" {
  name     = "lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "lb_attachment" {
  target_id        = var.instance_id
  port             = 80
  target_group_arn = aws_lb_target_group.lb_target_group.arn
}

resource "aws_lb_listener" "lb_front_end" {
  load_balancer_arn = aws_lb.tf_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
