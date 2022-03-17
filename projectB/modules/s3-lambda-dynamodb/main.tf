
# resource to create the aws s3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket-name}"
  force_destroy = true # delete the bucket fourcefully 
    
  tags = {
    Name = "${var.bucket-name}"
  }
}


# resource to create the aws dynamobd table
resource "aws_dynamodb_table" "pmc-dynamodb-table"{
    name =  "${var.name}"
    hash_key    =   "${var.hash_key}" # like primary key for the table
    read_capacity   =   "${var.read_capacity}"
    write_capacity   =   "${var.write_capacity}"

attribute{
    name    =   "${var.hash_key}"
    type    =   "S"  # type of the primary key S for string and N for the number etc
}
}

# data resource to create the zip file of the python function
data "archive_file" "welcome" {
  type        = "zip"
  source_file = "F:/GIIT/terraform-project-capsule/projectB/modules/s3-lambda-dynamodb/function.py"
  output_path = "outputs/welcome.zip"  # output path for the zip folder
}

# resource to create aws lambda function
resource "aws_lambda_function" "test_lambda" {
  filename      = "outputs/welcome.zip" # path of the python code zip file
  function_name = "welcome" # function name 
  role          = aws_iam_role.lambda_role.arn # attache the role to lambda function
  handler       = "function.lambda_handler" # lambda function handler
  #source_code_hash = "${filebase64sha256(locals.lambda_zip_location.zip)}"
  runtime = "python3.9" # python code version 

  
}

# resource to give the permission to s3 bucket (to trigger the s3 bucket by lambda function)
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn # s3 bucket arn
}

# this resource also need to trigger the s3 bucket by the lambda function
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn  # arn of the lambda function
    events              = ["s3:ObjectCreated:*"]
    #filter_prefix       = "AWSLogs/" # you can set the permission of any file with prefix
    #filter_suffix       = ".html" # you can set the permission of any file with suffix
  }

  depends_on = [aws_lambda_permission.allow_bucket] # depends_on meta-argument to handle hidden resource or module dependency
  
}















