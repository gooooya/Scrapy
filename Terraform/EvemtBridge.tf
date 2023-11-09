resource "aws_cloudwatch_event_rule" "my_scheduled_rule" {
  name                = "scraping-interval"
  description         = "Trigger Lambda on a schedule"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "my_lambda_target" {
  rule      = aws_cloudwatch_event_rule.my_scheduled_rule.name
  arn       = aws_lambda_function.scrapy_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_my_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scrapy_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.my_scheduled_rule.arn
}
