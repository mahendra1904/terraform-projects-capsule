resource "aws_iam_role_policy" "ebs_policy" {
  name = "ebs_policy_for_app"
  role = aws_iam_role.ebs_role.id
  policy =  "${file("F:/GIIT/terraform-project-capsule/projectB/modules/ebs-s3/ebs-policy.json")}"
}
resource "aws_iam_role" "ebs_role" {
  name = "ebs_role_app_deploy"
  assume_role_policy = "${file("F:/GIIT/terraform-project-capsule/projectB/modules/ebs-s3/assume_role_policy.json")}"
}