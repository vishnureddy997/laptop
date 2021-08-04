provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAWVHBCL6MUUPL7R7P"
    secret_key = "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"
}
resource "aws_s3_bucket" "vishnubucket" {
  bucket = "test-s3-vishnu"
  acl    = "private"

  tags = {
    Name        = "vishnubucket"
    Environment = "Test"
  }
}
resource "aws_s3_bucket_object" "object" {
  bucket = "test-s3-vishnu"
  key    = "king"
  source = "D:/terraformscripts/script2/s3bucket.tf"
  etag = filemd5("D:/terraformscripts/script2/s3bucket.tf")
}