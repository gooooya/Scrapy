# スクレイピング結果を保存するバケット
resource "aws_s3_bucket" "scrapy_output" {
  bucket = var.bucket_name
}