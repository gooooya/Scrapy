# 依存の解決を行うレイヤ
resource "aws_lambda_layer_version" "scrapy_layer" {
  layer_name = "scrapy_layer"
  filename      = "../tmp/layer.zip"
  compatible_runtimes = ["python3.11"]
  compatible_architectures = ["x86_64"]
}

# lambdaの内容をアップロード
resource "aws_lambda_function" "scrapy_lambda" {
  function_name = "scrapy_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "suumo/suumo/spiders/my_scrapy.lambda_handler"
  runtime       = "python3.11"
  filename      = "../tmp/scrapy.zip"
  layers        = [aws_lambda_layer_version.scrapy_layer.arn]
  timeout       = 900
  memory_size   = 512

  environment {
    variables = {
      MY_S3_BUCKET_NAME = aws_s3_bucket.scrapy_output.bucket
    }
  }
}


# lambda_roleの作成
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

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