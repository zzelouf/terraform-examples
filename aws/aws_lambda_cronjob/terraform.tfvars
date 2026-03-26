aws_region            = "us-east-1"
function_zipfile      = "lambda.zip"
cronjob_name          = "spacelift-demo-cronjob"
schedule_expression   = "rate(10 minutes)"
lambda_logging_enabled = true

tags = {
  Environment = "demo"
  Project     = "spacelift"
  CreatedBy   = "terraform"
}
