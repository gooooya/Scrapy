# states_roleの作成
resource "aws_iam_role" "states_role" {
  name = "states_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Lambda関数の呼び出し権
resource "aws_iam_role_policy" "lambda_invoke_policy" {
  name = "lambda_invoke_policy"
  role = aws_iam_role.states_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "${aws_lambda_function.scrapy_lambda.arn}"
    }
  ]
}
EOF
}

# ステートマシン定義
resource "aws_sfn_state_machine" "s3_state_machine" {
  name     = "S3StateMachine"
  role_arn = aws_iam_role.states_role.arn

  definition = <<EOF
{
  "Comment": "A simple AWS Step Functions state machine that executes a Lambda function.",
  "StartAt": "SaveToS3",
  "States": {
    "SaveToS3": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.scrapy_lambda.arn}",
      "End": true
    }
  }
}
EOF
}