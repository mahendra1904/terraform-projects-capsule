
resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_iam_role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}  
 # this resource can be work with policy.json file and we need to provide a policy.json file 
/* resource "aws_iam_role_policy" "codebuild_policy" {
  role = aws_iam_role.codebuild_role.name
    policy =  "${file("F:/GIIT/terraform-project-capsule/projectC/modules/iam-role-cicd/policy.json")}"

}  */



resource "aws_iam_role_policy_attachment" "codebuild-role-policy-attach1" {
  count      = "${length(var.managed_policies)}"
  policy_arn = "${element(var.managed_policies, count.index)}"
  role       = "${aws_iam_role.codebuild_role.name}"
}
