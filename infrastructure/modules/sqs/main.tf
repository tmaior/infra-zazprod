
locals {
  project_name = var.queue_name
}

#===============================================================================
# SQS QUEUE
#===============================================================================
resource "aws_sqs_queue" "this" {
  name                        = local.project_name
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  delay_seconds               = var.delay_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds

    # Configuring Dead Letter Queue (DLQ)
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn,
    maxReceiveCount     = var.max_receive_count
  })
}

# Dead Letter Queue (DLQ)
resource "aws_sqs_queue" "dlq" {
  name = "${local.project_name}-dlq"
}



