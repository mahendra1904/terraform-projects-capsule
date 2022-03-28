
# code build arn output
output "code_build_role_arn" {
    value = aws_iam_role.codebuild_role.arn

}