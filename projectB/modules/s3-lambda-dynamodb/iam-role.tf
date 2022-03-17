# iam role policy for the lmabda function to get the access for the s3 bucket and dynamodb table
resource "aws_iam_role_policy" "lambda_policy" {
  name = "labda_policy"
  role = aws_iam_role.lambda_role.id
  policy =  "${file("F:/GIIT/terraform-project-capsule/projectB/modules/s3-lambda-dynamodb/lambda-policy.json")}"
}

# iam role for the lambda lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = "${file("F:/GIIT/terraform-project-capsule/projectB/modules/s3-lambda-dynamodb/assume_role_policy.json")}"
}