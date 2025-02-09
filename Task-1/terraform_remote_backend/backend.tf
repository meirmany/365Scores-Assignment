# Create S3

resource "aws_s3_bucket" "mybucket" {
  bucket = "s3statebackend2922"
}

resource "aws_s3_bucket_acl" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create DynamoDB

resource "aws_dynamodb_table" "statelock" {
  name         = "state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}