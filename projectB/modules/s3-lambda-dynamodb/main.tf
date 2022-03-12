

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket-name}"
  force_destroy = true
    
  tags = {
    Name = "${var.bucket-name}"
  }
}



resource "aws_dynamodb_table" "pmc-dynamodb-table"{
    name =  "${var.name}"
    hash_key    =   "${var.hash_key}"
    read_capacity   =   "${var.read_capacity}"
    write_capacity   =   "${var.write_capacity}"

attribute{
    name    =   "${var.hash_key}"
    type    =   "S"
}
}


data "archive_file" "welcome" {
  type        = "zip"
  source_file = "F:/GIIT/terraform-project-capsule/projectB/modules/s3-lambda-dynamodb/function.py"
  output_path = "outputs/welcome.zip"
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "outputs/welcome.zip"
  function_name = "welcome"
  role          = aws_iam_role.lambda_role.arn
  handler       = "function.lambda_handler"
  #source_code_hash = "${filebase64sha256(locals.lambda_zip_location.zip)}"
  runtime = "python3.9"

  
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    #filter_prefix       = "AWSLogs/"
    #filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}















