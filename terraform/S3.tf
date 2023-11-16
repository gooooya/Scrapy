resource "aws_iam_role_policy" "lambda_s3_policy" {
  name = "lambda_s3_policy"
  role = aws_iam_role.lambda_role.id

policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.scrapy_output.arn}/*",
        "${aws_s3_bucket.scrapy_output.arn}"
      ]
    }
  ]
}
EOF
}

# スクレイピング結果を保存するバケット
resource "aws_s3_bucket" "scrapy_output" {
  bucket = var.bucket_name
}