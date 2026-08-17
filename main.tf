terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "zt_aws_vpc" {
  cidr_block           = "10.100.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_security_group" "zt_aws_sg" {
  name   = "zt-aws-orchestrator-sg"
  vpc_id = aws_vpc.zt_aws_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
