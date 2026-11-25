resource "aws_s3_bucket" "private_bucket" {
  bucket = "my-private-test-bucket-lab06"
}

resource "aws_s3_bucket_acl" "private" {
  bucket     = aws_s3_bucket.private_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.private]
}

resource "aws_s3_bucket_ownership_controls" "private" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "private" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "private" {
  bucket = aws_s3_bucket.private_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}