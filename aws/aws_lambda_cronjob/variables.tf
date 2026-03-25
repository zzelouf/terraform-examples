variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "cronjob_name" {
  description = "Name which will be used to create your Lambda function (e.g., \"my-important-cronjob\")"
  type        = string
  default     = "zachs_cronjob"
}

variable "name_prefix" {
  description = "Name prefix to use for objects that need to be created (only lowercase alphanumeric characters and hyphens allowed, for S3 bucket name compatibility)"
  type        = string
  default     = "sl-"
}

variable "comment_prefix" {
  description = "This will be included in comments for resources that are created"
  type        = string
  default     = "Lambda Cronjob: "
}

variable "schedule_expression" {
  description = "How often to run the Lambda (see https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html); e.g., \"rate(15 minutes)\" or \"cron(0 12 * * ? *)\""
  type        = string
  default     = "rate(60 minutes)"
}

variable "function_zipfile" {
  description = "Path to a ZIP file that will be installed as the Lambda function (e.g., \"my-cronjob.zip\")"
  type        = string
  default     = "lambda.zip"
}

variable "function_s3_bucket" {
  description = "When provided, the zipfile is retrieved from an S3 bucket by this name instead (filename is still provided via `function_zipfile`)"
  type        = string
  default     = ""
}

variable "function_handler" {
  description = "Instructs Lambda on which function to invoke within the ZIP file"
  type        = string
  default     = "index.handler"
}

variable "function_timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "function_runtime" {
  description = "Lambda runtime environment (e.g., nodejs18.x, nodejs20.x, python3.11, python3.12)"
  type        = string
  default     = "nodejs18.x"
}

variable "function_env_vars" {
  description = "Environment variables to pass to the Lambda function"
  type        = map(string)
  default = {
    # This effectively useless, but an empty map can't be used in the "aws_lambda_function" resource
    # -> this is 100% safe to override with your own env, should you need one
    aws_lambda_cronjob = ""
  }
}

variable "lambda_logging_enabled" {
  description = "When true, writes any console output to the Lambda function's CloudWatch group"
  type        = bool
  default     = false
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(string)
  default     = {}
}

locals {
  prefix_with_name = "${var.name_prefix}${replace(var.cronjob_name, "/[^a-z0-9-]+/", "-")}"
}
