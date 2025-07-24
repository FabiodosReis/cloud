
resource "aws_dynamodb_table" "lock_table" {
  name = "tf-lock-${aws_s3_bucket.remote_state.bucket}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}