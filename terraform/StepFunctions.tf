resource "aws_iam_role" "sfn_eventbridge_role" {
  name = "sfn_eventbridge_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "sfn_eventbridge_policy" {
  name = "sfn_eventbridge_policy"
  role = aws_iam_role.sfn_eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "states:StartExecution",
        Resource = "${aws_sfn_state_machine.s3_state_machine.arn}",
      }
    ]
  })
}


resource "aws_sfn_state_machine" "s3_state_machine" {
  name     = "S3StateMachine"
  role_arn = aws_iam_role.lambda_role.arn

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