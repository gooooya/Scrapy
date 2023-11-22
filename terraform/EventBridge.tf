# eventbridge_roleの作成
resource "aws_iam_role" "eventbridge_role" {
  name = "eventbridge_role"

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

# StepFunctionsの呼び出し権
resource "aws_iam_role_policy" "sfn_eventbridge_policy" {
  name = "sfn_eventbridge_policy"
  role = aws_iam_role.eventbridge_role.id

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

# 実行間隔定義
resource "aws_cloudwatch_event_rule" "my_scheduled_rule" {
  name                = "scraping-interval"
  description         = "Trigger sfn on a schedule"
  schedule_expression = "rate(7 days)"
}

# 実行対象定義
resource "aws_cloudwatch_event_target" "example_target" {
  rule      = aws_cloudwatch_event_rule.my_scheduled_rule.name
  target_id = "step-functions"
  arn       = aws_sfn_state_machine.s3_state_machine.arn
  role_arn  = aws_iam_role.eventbridge_role.arn
}