// DOCS
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAVV6ZACDFA43V6FEP"
  secret_key = "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"
}

// DOCS
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "tfs3bucket" {
  bucket = "tfs3"
}

resource "aws_s3_bucket_versioning" "tfs3bucket" {
  bucket = aws_s3_bucket.tfs3bucket.id // gets the id of the created bucket from line 18
  versioning_configuration {
    status = "Enabled"
  }
}

// DOCS
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration
resource "aws_s3_bucket_cors_configuration" "tfs3bucket" {
  bucket = aws_s3_bucket.tfs3bucket.id
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_ownership_controls" "tfs3bucket" {
  bucket = aws_s3_bucket.tfs3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tfs3bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.tfs3bucket]
  bucket     = aws_s3_bucket.tfs3bucket.id
  acl        = "private"
}


// TROUBLESHOOTING

// region mismatch:
// export AWS_DEFAULT_REGION="us-east-1"
