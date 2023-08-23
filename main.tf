resource "aws_s3_bucket" "mysecretfiles" {
  bucket = "mysecretfiles"
}

resource "aws_s3_bucket_website_configuration" "mysecretfiles" {
  bucket = aws_s3_bucket.mysecretfiles.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "mysecretfiles" {
  bucket = aws_s3_bucket.mysecretfiles.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "mysecretfiles" {
  bucket = aws_s3_bucket.mysecretfiles.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.mysecretfiles.arn,
          "${aws_s3_bucket.mysecretfiles.arn}/*",
        ]
      },
    ]
  })
}

# Note: index.html is intentionally manual to demo the aws s3 CLI.
# This demos copying files using Terraform
resource "aws_s3_object" "object_www" {
  depends_on   = [aws_s3_bucket.mysecretfiles]
  for_each     = fileset("${path.root}", "bucket-files/*.html")
  bucket       = "mysecretfiles"
  key          = basename(each.value)
  source       = each.value
  etag         = filemd5("${each.value}")
  content_type = "text/html"
  acl          = "public-read"
}