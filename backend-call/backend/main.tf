resource "aws_s3_bucket" "backend" {
  bucket = "bootcamp29-${random_integer.s3.result}-${var.name}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.backend.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "random_integer" "s3" {
  max = 100
  min = 1

  keepers = {
    bucket_owner = var.name
  }
}



