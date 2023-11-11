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

resource "aws_s3_bucket" "terraform-s3-bucket" {
  bucket = "terraform-s3-bucket-test1"
}

resource "aws_s3_bucket_versioning" "terraform-s3-versioning" {
  bucket = aws_s3_bucket.terraform-s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "terraform-s3-configuration" {
  bucket = aws_s3_bucket.terraform-s3-bucket.id
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

// Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "terraform-s3-controls" {
  bucket = aws_s3_bucket.terraform-s3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform-s3-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.terraform-s3-controls]
  bucket     = aws_s3_bucket.terraform-s3-bucket.id
  acl        = "private"
}
