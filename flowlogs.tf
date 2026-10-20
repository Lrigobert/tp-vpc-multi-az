resource "random_id" "log_bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "flow_logs" {
  bucket = "tp-vpc-flow-logs-${random_id.log_bucket_id.hex}"
  force_destroy = true
}

resource "aws_flow_log" "main" {
  log_destination      = aws_s3_bucket.flow_logs.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
}
