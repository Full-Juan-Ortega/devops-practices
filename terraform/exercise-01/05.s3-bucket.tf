resource "aws_s3_bucket" "bucket-01" {
  bucket = "juan-bucket-01-prueba"  
}
# ===========<---- aws_s3_bucket_acl nos permite darle permisos al bucket ---->===========#
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket-01.id
  acl    = "public-read"
}

