resource "aws_cloudwatch_event_rule" "my_scheduled_rule" {
  name                = "scraping-interval"
  description         = "Trigger sfn on a schedule"
  schedule_expression = "rate(15 minutes)"
}

resource "aws_cloudwatch_event_target" "example_target" {
  rule      = aws_cloudwatch_event_rule.my_scheduled_rule.name
  target_id = "step-functions"
  arn       = aws_sfn_state_machine.s3_state_machine.arn
  role_arn  = aws_iam_role.sfn_eventbridge_role.arn
}